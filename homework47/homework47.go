package main

import (
	"fmt"
	"math"
)

func main() {
	fmt.Println(add(5))
	fmt.Println(add(10))
	fmt.Println(add(9))
}

func add(x float64) float64 {
	var result float64
	for i := 1.0; i <= x; i++ {
		result += math.Pow(i, 2)
	}
	return result
}
