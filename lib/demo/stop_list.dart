import 'package:infotainment/src/model/dto/bus_route.dart';

final busStops = <BusStop>[
  BusStop(
    id: '1',

    lat: 11.44124487572325,
    lng: 75.69566708583649,

    name: StopName(
      en: "Koyilandy bus stand",
      ml: "കോയിലാണ്ടി ബസ് സ്റ്റാൻഡ്",
      hi: "कोयिलांडी बस स्टैंड",
    ),
    audio: "palayam.mp3",
    description: "Koyilandy bus stand, near SM Street.",
  ),
  BusStop(
    id: '2',

    lat: 11.440301757336641,
    lng: 75.70455006106745,
    name: StopName(en: "Komathukara", ml: "കൊമത്തുകര", hi: "कोमथुकारा"),
    audio: "medcollege.mp3",
    description: "Near Kozhikode Medical College Hospital.",
  ),
  BusStop(
    id: '3',

    lat: 11.43982402385905,
    lng: 75.71089037482898,
    name: StopName(en: "Aquaduct stop", ml: "ചെവായൂർ", hi: "चेवायूर"),
    audio: "chevayur.mp3",
    description: "Chevayur junction.",
  ),
  BusStop(
    id: '4',

    lat: 11.443197544353838,
    lng: 75.71817595326308,
    name: StopName(en: "Mavinchuvadu", ml: "മാവിഞ്ചുവാട്", hi: "माविनचुवाडु"),
    audio: "kunnamangalam.mp3",
    description: "Near National Institute of Technology Calicut.",
  ),
  BusStop(
    id: '5',

    lat: 11.444546705819803,
    lng: 75.72762894632992,
    name: StopName(en: "Kanayamkodu", ml: "കനയംകോട്", hi: "कनयमकोडु"),
    audio: "mavoor.mp3",
    description: "Kanayamkodu bus stop.",
  ),
  BusStop(
    id: '6',

    lat: 11.446667295162689,
    lng: 75.74053286951084,
    name: StopName(en: "Ollur stop", ml: "ഒള്ളൂർ", hi: "ओल्लूर"),
    audio: "mavoor.mp3",
    description: "Ollur bus stop, final stop.",
  ),
];

final Map<String, String> timeTableJson = {
  '10:00': 'KZD-16A',
  '11:15': 'KZD-17A',
  '12:30': 'KZD-17B',
  '14:05': 'KZD-17A',
  '15:20': 'KZD-17B',
  '17:50': 'KZD-17A',
  '17:57': 'KZD-17B',
  '19:00': 'KZD-16B',
};

final Map<DateTime, String> timeTable = {
  DateTime.parse('10:00'): 'KZD-16A',
  DateTime.parse('11:15'): 'KZD-17A',
  DateTime.parse('12:30'): 'KZD-17B',
  DateTime.parse('14:05'): 'KZD-17A',
  DateTime.parse('15:20'): 'KZD-17B',
  DateTime.parse('17:50'): 'KZD-17A',
  DateTime.parse('17:57'): 'KZD-17B',
  DateTime.parse('19:00'): 'KZD-16B',
};

final route = {
  'KZD-17': {
    'a': 'Koyilandy',
    'b': 'Thamarassery',
    'stops': [
      {
        "id": "stop001",
        "lat": 11.44124487572325,
        "lng": 75.69566708583649,
        "name": {
          "en": "Koyilandy bus stand",
          "ml": "കോയിലാണ്ടി ബസ് സ്റ്റാൻഡ്",
          "hi": "कोयिलांडी बस स्टैंड",
        },
        "audio": "palayam.mp3",

        "description": "Koyilandy bus stand, near SM Street.",
      },
    ],
  },
  'KZD-16': {
    'a': 'Koyilandy-Thamarassery',
    'b': 'Thamarassery-Koyilandy',
    'stops': [
      {
        "id": "stop001",
        "lat": 11.44124487572325,
        "lng": 75.69566708583649,
        "name": {
          "en": "Koyilandy bus stand",
          "ml": "കോയിലാണ്ടി ബസ് സ്റ്റാൻഡ്",
          "hi": "कोयिलांडी बस स्टैंड",
        },
        "audio": "palayam.mp3",

        "description": "Koyilandy bus stand, near SM Street.",
      },
    ],
  },
};
