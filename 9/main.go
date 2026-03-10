package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func minYearsToSurpass(aliceInitial, bobBonus, aliceRate, bobRate float64) (int, error) {
	if bobRate < aliceRate && bobBonus <= aliceInitial {
		return -1, nil
	}

	if bobRate == aliceRate && bobBonus <= aliceInitial {
		return -1, nil
	}

	if bobBonus > aliceInitial {
		return 0, nil
	}

	for i := 1; ; i++ {
		aliceInitial = aliceInitial * (1 + aliceRate)
		bobBonus = bobBonus * (1 + bobRate)
		if bobBonus > aliceInitial {
			return i, nil
		}
	}
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	scanner.Scan()
	aliceInitial, _ := strconv.ParseFloat(scanner.Text(), 32)

	scanner.Scan()
	bobBonus, _ := strconv.ParseFloat(scanner.Text(), 32)

	scanner.Scan()
	aliceRate, _ := strconv.ParseFloat(scanner.Text(), 32)

	scanner.Scan()
	bobRate, _ := strconv.ParseFloat(scanner.Text(), 32)

	result, err := minYearsToSurpass(aliceInitial, bobBonus, aliceRate, bobRate)
	if err != nil {
		panic(err)
	}
	fmt.Println(result)
}
