package main

import (
	"fmt"
	"runtime"
)

func main() {
	fmt.Printf("Hello from %s/%s!\n", runtime.GOOS, runtime.GOARCH)
	fmt.Println("This application runs in both Linux and Windows containers!")
}