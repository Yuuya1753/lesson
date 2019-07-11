package main

import (
	"fmt"
)

func main() {
	sliceA := make([]int, 10)

	for i := 1; i <= 10; i++ {
		sliceA = append(sliceA, i)
	}
	fmt.Printf("len=%d cap=%d\n", len(sliceA), cap(sliceA))

	for i := 11; i <= 100; i++ {
		sliceA = append(sliceA, i)
	}
	fmt.Printf("len=%d cap=%d\n", len(sliceA), cap(sliceA))

	for i := 101; i <= 1000; i++ {
		sliceA = append(sliceA, i)
	}
	fmt.Printf("len=%d cap=%d\n", len(sliceA), cap(sliceA))
}
