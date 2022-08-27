import type {
	SportsMap,
	SportsTagsMap,
	Tags
} from '@types/markets';

export const TAGS_LIST: Tags = [
	{ id: 9001, label: "NCAA Men's Football" },
	{ id: 9002, label: 'NFL' },
	{ id: 9003, label: 'MLB' },
	{ id: 9004, label: 'NBA' },
	{ id: 9005, label: "NCAA Men's Basketball" },
	{ id: 9006, label: 'NHL' },
	{ id: 9008, label: 'WNBA' },
	{ id: 9010, label: 'MLS' },
	{ id: 9011, label: 'EPL' },
	{ id: 9012, label: 'Ligue 1' },
	{ id: 9013, label: 'Bundesliga' },
	{ id: 9014, label: 'La Liga' },
	{ id: 9015, label: 'Seria A' },
	{ id: 9016, label: 'UEFA Champions League' }
];

export const SPORTS_MAP: SportsMap = {
	9001: 'Football',
	9002: 'Football',
	9003: 'Baseball',
	9004: 'Basketball',
	9005: 'Basketball',
	9006: 'Hockey',
	9008: 'Basketball',
	9010: 'Soccer',
	9011: 'Soccer',
	9012: 'Soccer',
	9013: 'Soccer',
	9014: 'Soccer',
	9015: 'Soccer',
	9016: 'Soccer'
};

export const SPORTS_TAGS_MAP: SportsTagsMap = {
	Football: [9001, 9002],
	Baseball: [9003],
	Basketball: [9004, 9005, 9008],
	Hockey: [9006],
	Soccer: [9010, 9011, 9012, 9013, 9014, 9015, 9016]
};
