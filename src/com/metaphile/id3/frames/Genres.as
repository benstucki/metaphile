package com.metaphile.id3.frames
{
	public class Genres
	{
		
		//********************************************
		// The following genres are defined in ID3v1 
		//********************************************
		
		public static const BLUES:int = 0; // 0.Blues
		public static const CLASSIC_ROCK:int = 1; // 1.Classic Rock
		public static const COUNTRY:int = 2; // 2.Country
		public static const DANCE:int = 3; // 3.Dance
		public static const DISCO:int = 4; // 4.Disco
		public static const FUNK:int = 5; // 5.Funk
		public static const GRUNGE:int = 6; // 6.Grunge
		public static const HIP_HOP:int = 7; // 7.Hip-Hop
		public static const JAZZ:int = 8; // 8.Jazz
		public static const METAL:int = 9; // 9.Metal
		public static const NEW_AGE:int = 10; // 10.New Age
		public static const OLDIES:int = 11; // 11.Oldies
		public static const OTHER:int = 12; // 12.Other
		public static const POP:int = 13; // 13.Pop
		public static const RNB:int = 14; // 14.R&B
		public static const RAP:int = 15; // 15.Rap
		public static const REGGAE:int = 16; // 16.Reggae
		public static const ROCK:int = 17; // 17.Rock
		public static const TECHNO:int = 18; // 18.Techno
		public static const INDUSTRIAL:int = 19; // 19.Industrial
		public static const ALTERNATIVE:int = 20; // 20.Alternative
		public static const SKA:int = 21; // 21.Ska
		public static const DEATH_METAL:int = 22; // 22.Death Metal
		public static const PRANKS:int = 23; // 23.Pranks
		public static const SOUNDTRACK:int = 24; // 24.Soundtrack
		public static const EURO_TECHNO:int = 25; // 25.Euro-Techno
		public static const AMBIENT:int = 26; // 26.Ambient
		public static const TRIP_HOP:int = 27; // 27.Trip-Hop
		public static const VOCAL:int = 28; // 28.Vocal
		public static const JAZZ_FUNK:int = 29; // 29.Jazz+Funk
		public static const FUSION:int = 30; // 30.Fusion
		public static const TRANCE:int = 31; // 31.Trance
		public static const CLASSICAL:int = 32; // 32.Classical
		public static const INSTRUMENTAL:int = 33; // 33.Instrumental
		public static const ACID:int = 34; // 34.Acid
		public static const HOUSE:int = 35; // 35.House
		public static const GAME:int = 36; // 36.Game
		public static const SOUND_CLIP:int = 37; // 37.Sound Clip
		public static const GOSPEL:int = 38; // 38.Gospel
		public static const NOISE:int = 39; // 39.Noise
		public static const ALTERNATIVE_ROCK:int = 40; // 40.AlternRock
		public static const BASS:int = 41; // 41.Bass
		public static const SOUL:int = 42; // 42.Soul
		public static const PUNK:int = 43; // 43.Punk
		public static const SPACE:int = 44; // 44.Space
		public static const MEDITATIVE:int = 45; // 45.Meditative
		public static const INSTRUMENTTAL_POP:int = 46; // 46.Instrumental Pop
		public static const INSTRUMENTAL_ROCK:int = 47; // 47.Instrumental Rock
		public static const ETHNIC:int = 48; // 48.Ethnic
		public static const GOTHIC:int = 49; // 49.Gothic
		public static const DARKWAVE:int = 50; // 50.Darkwave
		public static const TECHNO_INDUSTRIAL:int = 51; // 51.Techno-Industrial
		public static const ELECTRONIC:int = 52; // 52.Electronic
		public static const POP_FOLK:int = 53; // 53.Pop-Folk
		public static const EURODANCE:int = 54; // 54.Eurodance
		public static const DREAM:int = 55; // 55.Dream
		public static const SOUTHERN_ROCK:int = 56; // 56.Southern Rock
		public static const COMEDY:int = 57; // 57.Comedy
		public static const CULT:int = 58; // 58.Cult
		public static const GANGSTA:int = 59; // 59.Gangsta
		public static const TOP_40:int = 60; // 60.Top 40
		public static const CHRISTIAN_RAP:int = 61; // 61.Christian Rap
		public static const POP_FUNK:int = 62; // 62.Pop/Funk
		public static const JUNGLE:int = 63; // 63.Jungle
		public static const NATIVE_AMERICAN:int = 64; // 64.Native American
		public static const CABARET:int = 65; // 65.Cabaret
		public static const NEW_WAVE:int = 66; // 66.New Wave
		public static const PSYCHADELIC:int = 67; // 67.Psychadelic
		public static const RAVE:int = 68; // 68.Rave
		public static const SHOWTUNES:int = 69; // 69.Showtunes
		public static const TRAILER:int = 70; // 70.Trailer
		public static const LO_FI:int = 71; // 71.Lo-Fi
		public static const TRIBAL:int = 72; // 72.Tribal
		public static const ACID_PUNK:int = 73; // 73.Acid Punk
		public static const ACID_JAZZ:int = 74; // 74.Acid Jazz
		public static const POLKA:int = 75; // 75.Polka
		public static const RETRO:int = 76; // 76.Retro
		public static const MUSICAL:int = 77; // 77.Musical
		public static const ROCK_N_ROLL:int = 78; // 78.Rock & Roll
		public static const HARD_ROCK:int = 79; // 79.Hard Rock
		
		
		//********************************************
		// The following genres are Winamp extensions
		//********************************************
		
		public static const FOLK:int = 80; // 80.Folk
		public static const FOLK_ROCK:int = 81; // 81.Folk-Rock
		public static const NATIONAL_FOLK:int = 82; // 82.National Folk
		public static const SWING:int = 83; // 83.Swing
		public static const FAST_FUSION:int = 84; // 84.Fast Fusion
		public static const BEBOB:int = 85; // 85.Bebob
		public static const LATIN:int = 86; // 86.Latin
		public static const REVIVAL:int = 87; // 87.Revival
		public static const CELTIC:int = 88; // 88.Celtic
		public static const BLUEGRASS:int = 89; // 89.Bluegrass
		public static const AVANTGARDE:int = 90; // 90.Avantgarde
		public static const GOTHIC_ROCK:int = 91; // 91.Gothic Rock
		public static const PROGRESSIVE_ROCK:int = 92; // 92.Progressive Rock
		public static const PSYCHEDELIC_ROCK:int = 93; // 93.Psychedelic Rock
		public static const SYMPHONIC_ROCK:int = 94; // 94.Symphonic Rock
		public static const SLOW_ROCK:int = 95; // 95.Slow Rock
		public static const BIG_BAND:int = 96; // 96.Big Band
		public static const CHORUS:int = 97; // 97.Chorus
		public static const EASY_LISTENING:int = 98; // 98.Easy Listening
		public static const ACOUSTIC:int = 99; // 99.Acoustic
		public static const HUMOUR:int = 100; // 100.Humour
		public static const SPEECH:int = 101; // 101.Speech
		public static const CHANSON:int = 102; // 102.Chanson
		public static const OPERA:int = 103; // 103.Opera
		public static const CHAMBER_MUSIC:int = 104; // 104.Chamber Music
		public static const SONATA:int = 105; // 105.Sonata
		public static const SYMPHONY:int = 106; // 106.Symphony
		public static const BOOTY_BASS:int = 107; // 107.Booty Bass
		public static const PRIMUS:int = 108; // 108.Primus
		public static const PORN_GROOVE:int = 109; // 109.Porn Groove
		public static const SATIRE:int = 110; // 110.Satire
		public static const SLOW_JAM:int = 111; // 111.Slow Jam
		public static const CLUB:int = 112; // 112.Club
		public static const TANGO:int = 113; // 113.Tango
		public static const SAMBA:int = 114; // 114.Samba
		public static const FOLKLORE:int = 115; // 115.Folklore
		public static const BALLAD:int = 116; // 116.Ballad
		public static const POWER_BALLAD:int = 117; // 117.Power Ballad
		public static const RHYTHMIC_SOUL:int = 118; // 118.Rhythmic Soul
		public static const FREESTYLE:int = 119; // 119.Freestyle
		public static const DUET:int = 120; // 120.Duet
		public static const PUNK_ROCK:int = 121; // 121.Punk Rock
		public static const DRUM_SOLO:int = 122; // 122.Drum Solo
		public static const A_CAPELLA:int = 123; // 123.A capella
		public static const EURO_HOUSE:int = 124; // 124.Euro-House
		public static const DANCE_HALL:int = 125; // 125.Dance Hall
		
	}
}