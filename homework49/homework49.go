package main

import (
	"fmt"
)

func main() {
	fmt.Println(getString("abc", 3))
	fmt.Println(getString("ace", 2))
	fmt.Println(getString("xyz", 3))
	fmt.Println(getString("xyz", 27))
	fmt.Println(getString("xyz", -27))
}

func getString(a string, b int) string {
	words := []rune(a)
	size := len(words)
	var result string
	if b > 26 {
		b -= 26
	} else if b < -26 {
		b += 26
	}
	for i := 0; i < size; i++ {
		if int(words[i])+b > int('z') {
			words[i] = rune((int(words[i]) + b) - 26)
		} else {
			words[i] = rune(int(words[i]) + b)
		}
	}
	result = string(words)
	return result
}
