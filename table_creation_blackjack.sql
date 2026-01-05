CREATE TABLE sessions (
	id UUID PRIMARY KEY NOT NULL,
	user_name TEXT,
	started_at TIMESTAMP NOT NULL,
	ended_at TIMESTAMP,
	rules_json JSONB
);
CREATE TABLE blackjack_hands (
	id UUID PRIMARY KEY NOT NULL,
	session_id UUID NOT NULL REFERENCES sessions(id),
	round_index INT NOT NULL,
	hand_index INT NOT NULL,
	bet_cents INT NOT NULL,
	outcome TEXT NOT NULL,
	payout_cents INT NOT NULL,
	player_total INT,
	dealer_total INT,
	player_cards JSONB,
	dealer_cards JSONB,
	dealer_upcard TEXT,
	did_split BOOLEAN DEFAULT FALSE,
	did_double BOOLEAN DEFAULT FALSE,
	did_surrender BOOLEAN DEFAULT FALSE,
	created_at TIMESTAMP DEFAULT NOW()
);
CREATE INDEX ON blackjack_hands(session_id);

ALTER TABLE sessions
ALTER COLUMN id SET DEFAULT gen_random_uuid();
ALTER TABLE blackjack_hands
ALTER COLUMN id SET DEFAULT gen_random_uuid();