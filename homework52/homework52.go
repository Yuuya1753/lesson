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
	s := Square{1, 1, 10}
	fmt.Printf("X = %d, Y = %d\n", s.X, s.Y)

	s.Move(1, 0)
	fmt.Printf("X = %d, Y = %d\n", s.X, s.Y)

	s.Move(0, 1)
	fmt.Printf("X = %d, Y = %d\n", s.X, s.Y)

	s.Move(11, 22)
	fmt.Printf("X = %d, Y = %d\n", s.X, s.Y)
}

func (s *Square) Move(moveX int, moveY int) {
	s.X += moveX
	s.Y += moveY
}
