package main

import (
    "encoding/json"
    "net/http"
	"fmt"
)

func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(map[string]string{"message": "Hello, World!"})
    })
    http.ListenAndServe(":8080", nil)
}
