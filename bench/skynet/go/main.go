// Skynet の Go の双子（段 6 P4-6 — github.com/atemerev/skynet の Go 版と同じ形: goroutine ごとに 10 の子・結果はチャネルで親へ）
package main

import (
	"fmt"
	"os"
	"strconv"
)

func skynet(c chan int, num, size, div int) {
	if size == 1 {
		c <- num
		return
	}
	rc := make(chan int)
	sub := size / div
	for i := 0; i < div; i++ {
		go skynet(rc, num+i*sub, sub, div)
	}
	sum := 0
	for i := 0; i < div; i++ {
		sum += <-rc
	}
	c <- sum
}

func main() {
	n := 1000000
	if len(os.Args) >= 2 {
		n, _ = strconv.Atoi(os.Args[1])
	}
	c := make(chan int)
	go skynet(c, 0, n, 10)
	fmt.Println(<-c)
}
