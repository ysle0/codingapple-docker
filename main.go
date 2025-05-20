package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/go-chi/render"
)

type J map[string]string

func main() {
	r := chi.NewRouter()

	r.Use(middleware.Logger)
	r.Use(middleware.Compress(5, "gzip"))

	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		render.Status(r, http.StatusOK)
		render.JSON(w, r, J{
			"status": "OK",
		})
	})

	port := ":3090"
	fmt.Printf("serve at %v\n", port)
	log.Fatal(http.ListenAndServe(port, r))
}
