package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strings"

	"github.com/tiktoken-go/tokenizer"
)

type Podcast struct {
	Title   string
	IDs     []uint
	Matches int
}

func initDatabase() []Podcast {
	enc, err := tokenizer.Get(tokenizer.Cl100kBase)
	if err != nil {
		panic("oh oh")
	}

	inputFile := "/home/duncan/podcasts/titles.txt"
	f, _ := os.Open(inputFile)
	defer f.Close()
	scanner := bufio.NewScanner(f)
	num := 4000000
	podcasts := make([]Podcast, num)
	i := 0
	for scanner.Scan() {
		line := scanner.Text()
		ids, _, _ := enc.Encode(strings.ToLower(scanner.Text()))
		podcasts[i] = Podcast{
			Title: line,
			IDs:   ids,
		}
		i++
		if i >= num {
			break
		}
	}
	return podcasts
}

func main() {
	podcasts := initDatabase()
	fmt.Printf("Loaded %d podcasts\n", len(podcasts))
	enc, err := tokenizer.Get(tokenizer.Cl100kBase)
	if err != nil {
		panic("oh oh")
	}
	reader := bufio.NewReader(os.Stdin)
	for {
		fmt.Print("Enter a string: ")
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("Error reading input:", err)
			continue
		}
		ids, _, _ := enc.Encode(strings.TrimSpace(input))
		fmt.Println("Encoded IDs: ", ids)
		foundPodcasts := make([]Podcast, 0)
		for _, podcast := range podcasts {
			found := false
			// This is a copy I think
			foundPodcast := podcast
			for _, id := range ids {
				for _, podcastId := range foundPodcast.IDs {
					if podcastId == id {
						found = true
						foundPodcast.Matches++
						break
					}
				}
			}
			if found {
				foundPodcasts = append(foundPodcasts, foundPodcast)
			}
		}
		fmt.Printf("found %d podcasts\n", len(foundPodcasts))
		sort.Slice(foundPodcasts, func(i, j int) bool {
			return foundPodcasts[i].Matches > foundPodcasts[j].Matches
		})
		for i, foundPodcast := range foundPodcasts {
			fmt.Printf("Found Podcast: %s (%d matches) \n", foundPodcast.Title, foundPodcast.Matches)
			if i > 10 {
				break
			}
		}
	}
}
