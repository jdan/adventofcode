import sys
import typing
import functools

Card = typing.Literal[2, 3, 4, 5, 6, 7, 8, 9, "T", "J", "Q", "K", "A"]

def int_of_card(card: Card) -> int:
    if card == "T":
        return 10
    elif card == "J":
        return 11
    elif card == "Q":
        return 12
    elif card == "K":
        return 13
    elif card == "A":
        return 14
    else:
        return int(card)

FIVE_OF_A_KIND = 6
FOUR_OF_A_KIND = 5
FULL_HOUSE = 4
THREE_OF_A_KIND = 3
TWO_PAIR = 2
ONE_PAIR = 1
HIGH_CARD = 0

class Hand:
    def __init__(self, cards: list[Card], wager: int):
        self.cards = cards
        self.wager = wager

    def value_of_hand(self):
        """
        Return the value of the hand, as an integer.
        """
        counts = {}
        for card in self.cards:
            if card not in counts:
                counts[card] = 0
            counts[card] += 1

        # if counts contains a 5...
        if 5 in counts.values():
            return FIVE_OF_A_KIND
        elif 4 in counts.values():
            return FOUR_OF_A_KIND
        elif 3 in counts.values() and 2 in counts.values():
            return FULL_HOUSE
        elif 3 in counts.values():
            return THREE_OF_A_KIND
        elif list(counts.values()).count(2) == 2:
            return TWO_PAIR
        elif 2 in counts.values():
            return ONE_PAIR
        else:
            return HIGH_CARD

    def compare(self, other) -> int:
        if self.value_of_hand() > other.value_of_hand():
            return 1
        elif self.value_of_hand() < other.value_of_hand():
            return -1
        else:
            # step through each card, comparing them
            for i in range(len(self.cards)):
                if int_of_card(self.cards[i]) > int_of_card(other.cards[i]):
                    return 1
                elif int_of_card(self.cards[i]) < int_of_card(other.cards[i]):
                    return -1
            return 0

    def __repr__(self):
        return f"{self.cards} ({self.value_of_hand()})"

hands: list[Hand] = []
for line in sys.stdin:
    cards, wager = line.split(" ")
    wager = int(wager)
    cards = typing.cast(list[Card], list(cards))

    hands.append(Hand(cards, wager))

winnings = 0
hands.sort(key=functools.cmp_to_key(lambda a, b: a.compare(b)))

for idx, hand in enumerate(hands):
    winnings += (idx + 1) * hand.wager

print(winnings)
