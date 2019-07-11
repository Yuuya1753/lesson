package main

import (
	"fmt"
)

type Square struct {
	X       int
	Y       int
	SideLen int
}

func main() {
	fmt.Println(overlap(1, 1, 10, 5, 5, 10))
	fmt.Println(overlap(5, 5, 10, 1, 1, 10))
	fmt.Println(overlap(1, 1, 10, 11, 1, 10))
	fmt.Println(overlap(10, 1, 10, 1, 1, 10))
}

func overlap(aX int, aY int, aSideLen int, bX int, bY int, bSideLen int) bool {
	a := Square{aX, aY, aSideLen}
	b := Square{bX, bY, bSideLen}

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
