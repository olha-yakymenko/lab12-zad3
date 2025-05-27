package main

import (
	"fmt"
	"runtime"
)

func main() {
	// Mapowanie wiadomości powitalnych
	messages := map[string]string{
		"windows": "Witaj z kontenera Windows!",
		"linux":   "Witaj z kontenera Linux!",
		"darwin":  "Witaj z macOS!",
	}

	// Domyślna wiadomość dla nieznanego systemu
	message, ok := messages[runtime.GOOS]
	if !ok {
		message = fmt.Sprintf("Witaj z %s (nieobsługiwany system)!", runtime.GOOS)
	}

	// Wyświetl informacje
	fmt.Println(message)
	fmt.Printf("System: %s, Architektura: %s\n", runtime.GOOS, runtime.GOARCH)
}