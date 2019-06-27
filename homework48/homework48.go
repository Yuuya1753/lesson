package main

import (
	"fmt"
	"math"
)

func main() {
	fmt.Println(sqrtCount(9, 2))
	fmt.Println(sqrtCount(64, 2))
	fmt.Println(sqrtCount(64, 4))
}

func sqrtCount(a, b float64) int {
	result := 1
	x := math.Sqrt(a)
	for x > b {
		result++
		x = math.Sqrt(x)
	}
	return result
}
