package main

import (
    "log"
    "net/http"
)

func main() {
    http.Handle("/", http.FileServer(http.Dir(".")))
    log.Println("Listening on :25252...")
    http.ListenAndServe(":25252", nil)
}
