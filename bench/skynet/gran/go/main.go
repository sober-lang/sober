package main

import (
	"fmt"
	"os"
	"strconv"
)

func leaf(num, l int) int {
	a := 0
	for i := 0; i < l; i++ {
		a += i ^ num
	}
	return num + a - a
}

func skynet(c chan int, num, size, div, l int) {
	if size == 1 {
		c <- leaf(num, l)
		return
	}
	rc := make(chan int)
	sub := size / div
	for i := 0; i < div; i++ {
		go skynet(rc, num+i*sub, sub, div, l)
	}
	sum := 0
	for i := 0; i < div; i++ {
		sum += <-rc
	}
	c <- sum
}

func main() {
	n, _ := strconv.Atoi(os.Args[1])
	l, _ := strconv.Atoi(os.Args[2])
	c := make(chan int)
	go skynet(c, 0, n, 10, l)
	fmt.Println(<-c)
}
