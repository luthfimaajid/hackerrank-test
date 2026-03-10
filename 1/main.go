package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"os"
	"strconv"
)

const API = `https://jsonmock.hackerrank.com/api/football_matches`

type Response struct {
	Page       int            `json:"page"`
	PerPage    int            `json:"per_page"`
	Total      int            `json:"total"`
	TotalPages int            `json:"total_pages"`
	Data       []ResponseData `json:"data"`
}

type ResponseData struct {
	Competition string `json:"competition"`
	Year        int    `json:"year"`
	Round       string `json:"round"`
	Team1       string `json:"team1"`
	Team2       string `json:"team2"`
	Team1Goals  string `json:"team1goals"`
	Team2Goals  string `json:"team2goals"`
}

func getTotalGoal(isTeam1 bool, year int, team string) (int, error) {
	totalGoal := 0
	hasNextPage := true

	teamParam := "team2"
	if isTeam1 {
		teamParam = "team1"
	}

	for i := 1; hasNextPage; i++ {
		params := url.Values{}
		params.Set("year", fmt.Sprintf("%d", year))
		params.Set(teamParam, team)
		params.Set("page", fmt.Sprintf("%d", i))
		url := "https://jsonmock.hackerrank.com/api/football_matches?" + params.Encode()

		resp, err := http.Get(url)
		if err != nil {
			return 0, err
		}
		defer resp.Body.Close()

		body, err := io.ReadAll(resp.Body)
		if err != nil {
			panic(err)
		}

		var response Response
		err = json.Unmarshal(body, &response)
		if err != nil {
			panic(err)
		}

		if response.Total == 0 {
			break
		}

		for _, d := range response.Data {
			g := 0
			if isTeam1 {
				g, err = strconv.Atoi(d.Team1Goals)
			} else {
				g, err = strconv.Atoi(d.Team2Goals)
			}

			if err != nil {
				continue
			}

			totalGoal += g
		}

		hasNextPage = !(response.Page == response.TotalPages)
	}

	return totalGoal, nil
}

func solution(year int, team string) (int, error) {
	type result struct {
		goal int
		err  error
	}

	ch := make(chan result, 2)

	go func() {
		goal, err := getTotalGoal(true, year, team)
		ch <- result{goal, err}
	}()

	go func() {
		goal, err := getTotalGoal(false, year, team)
		ch <- result{goal, err}
	}()

	total := 0
	for range 2 {
		r := <-ch
		if r.err != nil {
			return 0, r.err
		}
		total += r.goal
	}

	return total, nil
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	scanner.Scan()
	year, _ := strconv.Atoi(scanner.Text())

	scanner.Scan()
	team := scanner.Text()

	result, err := solution(year, team)
	if err != nil {
		panic(err)
	}
	fmt.Println(result)
}
