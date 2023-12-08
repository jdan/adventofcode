import sys
import typing
import functools

Card = typing.Literal[2, 3, 4, 5, 6, 7, 8, 9, "T", "J", "Q", "K", "A"]

def int_of_card(card: Card) -> int:
    if card == "T":
        return 10
    # J is now joker
    elif card == "J":
        return 1
    elif card == "Q":
        return 12
    elif card == "K":
        return 13
    elif card == "A":
        return 14
    else:
        return int(card)

def card_of_int(card: int) -> Card:
    if card == 10:
        return "T"
    elif card == 12:
        return "Q"
    elif card == 13:
        return "K"
    elif card == 14:
        return "A"
    elif card == 2:
        return 2
    elif card == 3:
        return 3
    elif card == 4:
        return 4
    elif card == 5:
        return 5
    elif card == 6:
        return 6
    elif card == 7:
        return 7
    elif card == 8:
        return 8
    elif card == 9:
        return 9

    raise Exception(f"Invalid card: {card}")

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
            # I'm so sorry
            s_card = str(card)
            if s_card not in counts:
                counts[s_card] = 0
            counts[s_card] += 1

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

    # can likely cache this?
    def best_value_of_hand(self):
        """
        Gets the best possible value of a hand, substituting all Js for every possible card
        """
        possible_hands = []

        # this is assuming all jokes in a hand should be the same card
        # ... which I think is true but is definitely suspect
        for i in range(2, 15):
            # skip 11, which is Jack and is not available
            if i == 11:
                continue

            possible_hand = []
            for card in self.cards:
                if card == "J":
                    possible_hand.append(card_of_int(i))
                else:
                    possible_hand.append(card)
            possible_hands.append(possible_hand)

        # wager doesn't matter
        return max([Hand(h, 0).value_of_hand() for h in possible_hands])

    def compare(self, other) -> int:
        if self.best_value_of_hand() > other.best_value_of_hand():
            return 1
        elif self.best_value_of_hand() < other.best_value_of_hand():
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
