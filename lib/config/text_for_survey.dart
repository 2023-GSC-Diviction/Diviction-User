import 'package:flutter/material.dart';

const List<String> drug_question = [
  'Have you used any of the following drugs in the past year?',
  'How often have you used these drugs?',
  '1. Have you used drugs other than those required for medical reasons?',
  '2. Do you abuse more than one drug at a time?',
  '3. Are you always able to stop using drugs when you want to?',
  '4. Have you ever had blackouts or flashbacks as a result of drug use?',
  '5. Do you ever feel bad or guilty about your drug use?',
  '6. Does your spouse (or parents) ever complain about your involvement with drugs?',
  '7. Have you neglected your family because of your use of drugs?',
  '8. Have you engaged in illegal activities in order to obtain drugs?',
  '9. Have you ever experienced withdrawal symptoms (felt sick) when you stopped taking drugs?',
  '10. Have you had medical problems as a result of your drug use (e.g. memory loss, hepatitis, convulsions, bleeding)?',
  'Have you ever injected drugs?',
  'Have you ever been in treatment for substance abuse?',
];

const Map<int, List<String>> drug_answer = {
  -1: [
    'PEN',
    'PHIL',
    'COCAINE',
    'WEED',
    'HERO',
    'INHALE',
    'LSD',
    'VAL',
    'ELSE'

  ],
  0: ['Monthly or less', 'Weekly', 'Daily or almost daily'],
  1: ['No', 'Yes'],
  2: ['No', 'Yes'],
  3: ['No', 'Yes'],
  4: ['No', 'Yes'],
  5: ['No', 'Yes'],
  6: ['No', 'Yes'],
  7: ['No', 'Yes'],
  8: ['No', 'Yes'],
  9: ['No', 'Yes'],
  10: ['No', 'Yes'],
  11: ['Never', 'Yes, in the past 90 days ', 'Yes, more than 90 days ago'],
  12: ['Never', 'Currently', 'In the past'],
};

const List<String> alcohol_question = [
  '',
  '1. How often do you have a drink containing alcohol?',
  '2. How many drinks containing alcohol do you have on a typical day when you are drinking?',
  '3. How often do you have four or more drinks on one occasion? ',
  '4. How often during the last year have you found that you were not able to stop drinking once you had started?',
  '5. How often during the last year have you failed to do what was normally expected of you because of drinking?',
  '6. How often during the last year have you needed a first drink in the morning to get yourself going after a heavy drinking session?',
  '7. How often during the last year have you had a feeling of guilt or remorse after drinking? ',
  '8. How often during the last year have you been unable to remember what happened the night before because of your drinking?',
  '9. Have you or someone else been injured because of your drinking? ',
  '10. Has a relative, friend, doctor, or other health care worker been concerned about your drinking or suggested you cut down?',
  '11. Have you ever been in treatment for alcohol use?',
];

const Map<int, List<String>> alcohol_answer = {
  1: ['Never', 'Monthly or less', '2 - 4 times a month', '2 - 3 times a week', '4 or more times a week'],
  2: ['0 - 2', '3 or 4', '5 or 6', '7 - 9', '10 or more'],
  3: ['Never', 'Less than monthly', 'Monthly', 'Weekly', 'Daily or almost daily'],
  4: ['Never', 'Less than monthly', 'Monthly', 'Weekly', 'Daily or almost daily'],
  5: ['Never', 'Less than monthly', 'Monthly', 'Weekly', 'Daily or almost daily'],
  6: ['Never', 'Less than monthly', 'Monthly', 'Weekly', 'Daily or almost daily'],
  7: ['Never', 'Less than monthly', 'Monthly', 'Weekly', 'Daily or almost daily'],
  8: ['Never', 'Less than monthly', 'Monthly', 'Weekly', 'Daily or almost daily'],
  9: ['No', 'Yes, but not in the last year', 'Yes, in the last year'],
  10: ['No', 'Yes, but not in the last year', 'Yes, in the last year'],
  11: ['Never', 'Currently', 'In the past'],
};

const List<String> psychological_question = [
  '',
  '1. I found it hard to wind down',
  '2. I was aware of dryness of my mouth',
  '3. I couldn’t seem to experience any positive feeling at all',
  '4. I experienced breathing difficulty (e.g. excessively rapid breathing, breathlessness in the absence of physical exertion)',
  '5. I found it difficult to work up the initiative to do things',
  '6. I tended to over-react to situations',
  '7. I experienced trembling (e.g. in the hands)',
  '8. I felt that I was using a lot of nervous energy',
  '9. I was worried about situations in which I might panic and make a fool of myself',
  '10. I felt that I had nothing to look forward to',
  '11. I found myself getting agitated',
  '12. I found it difficult to relax',
  '13. I felt down-hearted and blue',
  '14. I was intolerant of anything that kept me from getting on with what I was doing',
  '15. I felt I was close to panic',
  '16. I was unable to become enthusiastic about anything',
  '17. I felt I wasn’t worth much as a person',
  '18. I felt that I was rather touchy',
  '19. I was aware of the action of my heart in the absence of physical exertion (e.g. sense of heart rate increase, heart missing a beat)',
  '20. I felt scared without any good reason',
  '21. I felt that life was meaningless',
];

const Map<String, List<String>> psychological_answer = {
  'All': [
    'Did not apply to me at all',
    'Applied to me to some degree, or some of the time',
    'Applied to me to a considerable degree or a good part of time',
    'Applied to me very much or most of the time'
  ]
};

// const List<String> question_pre = [
//   '1. 지금까지 살면서 다음 중 사용해 본적이 있었던 약물을 모두 체크하세요.\n(단, 치료 목적으로 사용한 의약품은 제외)',
//   '2. 아래의 약물을 지난 3개월 간 얼마나 자주 사용했습니까?',
//   '3. 아래의 약물을 사용하고 싶은 강한 욕구가 지난 3개월 간 얼마나 자주 있었습니까?',
//   '4. 당신이 아래의 약물을 사용함으로써 지난 3개월 간 건강, 대인관계, 법 및 금전적인 문제가 얼마나 자주 발생했습니까?',
//   '5. 아래의 약물 사용으로 인해 해야 할 일을 하지 못한 적이 지난 3개월 간 얼마나 자주 있었습니까?',
//   '6. 가족, 친구, 친척 등 누군가가 한번이라도 당신의 약물 사용을 걱정한 적이 있습니까?',
//   '7. 아래의 약물 사용을 조절하거나 끊으려고 노력했으나 실패한 적이 있습니까?',
//   '8. 치료 이외의 목적으로, 주사기로 약물을 투여한 적이 있습니까?'
// ];
//
// const Map<int, List<String>> answer_pre = {
//   1: [
//     'a. 메트암페타민 (아이스, 히로뽕)',
//     'b. 대마제제 (마리화나, 대마초, 해쉬쉬)',
//     'c. 처방전이 필요한 흥분제 (비만치료제(펜터민), 공부잘하는 약(메칠페니데이트) 등)',
//     'd. 코카인 (코카인, 크랙)',
//     'e. 아편제제 (양귀비, 아편, 생아편, 헤로인 등)',
//     'f. 흡입제 (본드, 부탄, 신너, 아산화질소(포펠스))',
//     'g. 진정, 수면제 (바륨, 아티반, 자낙스, 할시온, 스틸록스(졸피뎀) 등)',
//     'h. 환각제 (엑스터시, LSD, PCP, 케타민, 합성대마)',
//     'i. 처방전이 필요한 아편제제 (모르핀, 코데인, 옥시코돈, 하이드로코돈, 펜타닐, 하이드로몰폰, 페치딘 등)',
//     'j. 기타 (신종 마약류)'
//   ],
//   2: ['사용안함', '1, 2번', '매달', '매주', '매일 혹은 거의매일'],
//   3: ['없다', '1, 2번', '매달', '매주', '매일 혹은 거의매일'],
//   4: ['없다', '1, 2번', '매달', '매주', '매일 혹은 거의매일'],
//   5: ['없다', '1, 2번', '매달', '매주', '매일 혹은 거의매일'],
//   6: ['없다', '있으나, 최근 1년은 없었다', '있다'],
//   7: ['없다', '있으나, 최근 1년은 없었다', '있다'],
//   8: ['없다', '있으나, 최근 1년은 없었다', '있다'],
// };
//
