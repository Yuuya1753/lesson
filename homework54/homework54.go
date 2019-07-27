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
	rand.Seed(time.Now().UnixNano())
	for i := 0; i < 10; i++ {
		sq := Square{rand.Intn(1000), rand.Intn(1000), rand.Intn(500)}
		if i == 0 {
			squareSlice = append(squareSlice, sq)
			fmt.Printf("%d個目 X = %d Y = %d 辺の長さ = %d   追加しました。\n", i, sq.X, sq.Y, sq.SideLen)
		} else {
			if !findOverlap(sq, squareSlice) {
				squareSlice = append(squareSlice, sq)
				fmt.Printf("%d個目 X = %d Y = %d 辺の長さ = %d   追加しました。\n", i, sq.X, sq.Y, sq.SideLen)
			} else {
				fmt.Printf("%d個目 X = %d Y = %d 辺の長さ = %d   追加しませんでした。\n", i, sq.X, sq.Y, sq.SideLen)
			}
		}
		time.Sleep(2 * time.Second)
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

func findOverlap(s Square, ss []Square) bool {
	for _, v := range ss {
		if overlap(s, v) {
			return true
		}
	}
	return false
}
