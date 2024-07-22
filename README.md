# Alquran Digital

## Description
Alquran Digital is a simple Quran app developed using Flutter, integrating the [Equran API](https://equran.id/apidev/v2) to provide access to Quranic verses, chapters, tafsir, and audio.

## Features
- **View Surahs**: List all surahs from the Quran.
- **View Ayahs**: List ayahs of a selected surah.
- **View Tafsir**: Read tafsir for each ayah.
- **Play Audio**: Play audio recitation for each surah.

## Project Structure
```plaintext
lib/
├── app/
│   ├── const/
│   └── route/
│   └── view/
│       └── atom/
├── bloc/
├── models/
├── services/
└── view/
    ├── molecule/
    ├── organism/
    └── pages/
pubspec.yaml
README.md
```

## API Integration
This app uses the Equran API to fetch Quranic data. The API endpoints include:

- /api/v2/surat: Get a list of all surahs.
- /api/v2/surat/:nomor: Get details of a specific surah.
- /api/v2/tafsir/:nomor: Get tafsir for a specific ayah.

## Usage
- View Surahs: Open the app to view a list of all surahs.
- View Ayahs: Select a surah to view its ayahs.
- View Tafsir: Read tafsir for each ayah by selecting it.
- Play Audio: Play audio recitation for each surah.

<br>

Thank you for using Alquran Digital. We hope it helps you in your spiritual journey.

Best regards,

Asbiq Al Alawi
