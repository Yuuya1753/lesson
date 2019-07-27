package main

import (
	"fmt"
	"math/rand"
	"time"
)

type Square struct {
	X       int
	Y       int
	SideLen int
}

func main() {
	var squareSlice []Square
	result := make([]int, 0)
	rand.Seed(time.Now().UnixNano())
	for i := 0; i < 10; i++ {
		squareSlice = append(squareSlice, Square{rand.Intn(1000), rand.Intn(1000), rand.Intn(500)})
	}
	for i := 0; i < 10; i++ {
		for j := i + 1; j < 10; j++ {
			if overlap(squareSlice[i], squareSlice[j]) {
				if !findIndex(i, result) {
					result = append(result, i)
				}
				if !findIndex(j, result) {
					result = append(result, j)
				}
			}
		}
	}
	for i, v := range squareSlice {
		fmt.Printf("%d個目 X = %d Y = %d 辺の長さ = %d\n", i, v.X, v.Y, v.SideLen)
	}
	for _, v := range result {
		if len(result) != 1 {
			fmt.Println(v)
		}
	}
}

func overlap(a Square, b Square) bool {
	if a.X < b.X {
		if a.Y < b.Y {
			if (a.X+a.SideLen > b.X) && (a.Y+a.SideLen > b.Y) {
				return true
			}
		} else {
			if (a.X+a.SideLen > b.X) && (b.Y+b.SideLen > a.Y) {
				return true
			}
		}
	} else {
		if a.Y < b.Y {
			if (b.X+b.SideLen > a.X) && (a.Y+a.SideLen > b.Y) {
				return true
			}
		} else {
			if (b.X+b.SideLen > a.X) && (b.Y+b.SideLen > a.Y) {
				return true
			}
		}
	}
	return false
}

func findIndex(i int, r []int) bool {
	for _, v := range r {
		if v == i {
			return true
		}
	}
	return false
}
