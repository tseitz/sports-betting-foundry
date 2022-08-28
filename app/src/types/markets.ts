export type TagInfo = {
	id: number;
	label: string;
};

export type Tags = TagInfo[];

export type SportsMap = Record<number, string>;

export type SportsTagsMap = Record<string, number[]>;

export type SportMarketInfo = {
	id: string;
	address: string;
	maturityDate: number; // really Date but timestamp
	tags: string[]; // really these are numbers but they come in as strings
	isOpen: boolean;
	isResolved: boolean;
	isCanceled: boolean;
	finalResult: number;
	poolSize: number;
	numberOfParticipants: number;
	homeTeam: string;
	awayTeam: string;
	homeOdds: number;
	awayOdds: number;
	drawOdds: number;
	homeScore: number;
	awayScore: number;
	sport: string;
	timestamp: number; // really Date but timestamp
	homeBetAmount: number; // our mapping for amount
	awayBetAmount: number; // our mapping for amount
};
