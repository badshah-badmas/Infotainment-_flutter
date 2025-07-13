import 'package:infotainment/src/model/dto/bus_route.dart';
import 'package:infotainment/src/model/dto/time_table.dart';

class Demo {
  static final List<TimeTableItem> timeTable = [
    TimeTableItem.fromJson({
      'start': '10:00',
      'end': '11:00',
      'route': 'KZD-16',
      'direction': 'a',
    }),
    TimeTableItem.fromJson({
      'start': '11:15',
      'end': '12:15',
      'route': 'KZD-17',
      'direction': 'a',
    }),
    TimeTableItem.fromJson({
      'start': '12:30',
      'end': '13:30',
      'route': 'KZD-17',
      'direction': 'b',
    }),
    TimeTableItem.fromJson({
      'start': '14:05',
      'end': '15:05',
      'route': 'KZD-17',
      'direction': 'a',
    }),
    TimeTableItem.fromJson({
      'start': '15:20',
      'end': '16:20',
      'route': 'KZD-17',
      'direction': 'b',
    }),
    TimeTableItem.fromJson({
      'start': '16:50',
      'end': '17:50',
      'route': 'KZD-17',
      'direction': 'a',
    }),
    TimeTableItem.fromJson({
      'start': '17:57',
      'end': '19:00',
      'route': 'KZD-17',
      'direction': 'b',
    }),
    TimeTableItem.fromJson({
      'start': '19:05',
      'end': '20:00',
      'route': 'KZD-16',
      'direction': 'b',
    }),
  ];
  static final Map<String, BusRoute> routes = {
    'kzd-17': BusRoute.fromJson({
      'route': 'KZD-17',
      'a': 'Koyilandy',
      'b': 'Thamarassery',
      'stops': [
        {
          "id": "1",
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
        {
          "id": "2",
          "lat": 11.440301757336641,
          "lng": 75.70455006106745,
          "name": {"en": "Komathukara", "ml": "കൊമത്തുകര", "hi": "कोमथुकारा"},
          "audio": "medcollege.mp3",
          "description": "Near Kozhikode Medical College Hospital.",
        },
        {
          "id": "3",
          "lat": 11.43982402385905,
          "lng": 75.71089037482898,
          "name": {"en": "Aquaduct stop", "ml": "ചെവായൂർ", "hi": "चेवायूर"},
          "audio": "chevayur.mp3",
          "description": "Chevayur junction.",
        },
        {
          "id": "4",
          "lat": 11.443197544353838,
          "lng": 75.71817595326308,
          "name": {
            "en": "Mavinchuvadu",
            "ml": "മാവിഞ്ചുവാട്",
            "hi": "माविनचुवाडु",
          },
          "audio": "kunnamangalam.mp3",
          "description": "Near National Institute of Technology Calicut.",
        },
        {
          "id": "5",
          "lat": 11.444546705819803,
          "lng": 75.72762894632992,
          "name": {"en": "Kanayamkodu", "ml": "കനയംകോട്", "hi": "कनयमकोडु"},
          "audio": "mavoor.mp3",
          "description": "Kanayamkodu bus stop.",
        },
        {
          "id": "6",
          "lat": 11.446667295162689,
          "lng": 75.74053286951084,
          "name": {"en": "Ollur stop", "ml": "ഒള്ളൂർ", "hi": "ओल्लूर"},
          "audio": "mavoor.mp3",
          "description": "Ollur bus stop, final stop.",
        },
      ],
    }),
    'kzd-16': BusRoute.fromJson({
      'route': 'KZD-16',
      'a': 'Kozhikode',
      'b': 'Mavoor',
      'stops': [
        {
          "id": "1",
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
        {
          "id": "2",
          "lat": 11.440301757336641,
          "lng": 75.70455006106745,
          "name": {"en": "Komathukara", "ml": "കൊമത്തുകര", "hi": "कोमथुकारा"},
          "audio": "medcollege.mp3",
          "description": "Near Kozhikode Medical College Hospital.",
        },
        {
          "id": "3",
          "lat": 11.43982402385905,
          "lng": 75.71089037482898,
          "name": {"en": "Aquaduct stop", "ml": "ചെവായൂർ", "hi": "चेवायूर"},
          "audio": "chevayur.mp3",
          "description": "Chevayur junction.",
        },
        {
          "id": "4",
          "lat": 11.443197544353838,
          "lng": 75.71817595326308,
          "name": {
            "en": "Mavinchuvadu",
            "ml": "മാവിഞ്ചുവാട്",
            "hi": "माविनचुवाडु",
          },
          "audio": "kunnamangalam.mp3",
          "description": "Near National Institute of Technology Calicut.",
        },
        {
          "id": "5",
          "lat": 11.444546705819803,
          "lng": 75.72762894632992,
          "name": {"en": "Kanayamkodu", "ml": "കനയംകോട്", "hi": "कनयमकोडु"},
          "audio": "mavoor.mp3",
          "description": "Kanayamkodu bus stop.",
        },
        {
          "id": "6",
          "lat": 11.446667295162689,
          "lng": 75.74053286951084,
          "name": {"en": "Ollur stop", "ml": "ഒള്ളൂർ", "hi": "ओल्लूर"},
          "audio": "mavoor.mp3",
          "description": "Ollur bus stop, final stop.",
        },
      ],
    }),
  };
}

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
