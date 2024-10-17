-- 함수 : 컬럼의 값을 읽어서 연산을 한 결과를 반환

-- 단일 행 함수 : N개의 값을 읽어서 연산 후 N개의 결과를 반환

-- 그룹 함수 : N개의 값을 읽어서 연산 후 1개의 결과를 반환(합계, 평균, 최대, 최소)

-- 함수는 SELECT 문의 SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절 에서 사용 가능



-------------------------------------단일 행 함수 ------------------------------------

-- LENGTH(컬럼명 | 문자열) : 길이 반환
SELECT EMAIL, LENGTH(EMAIL) FROM EMPLOYEE ORDER BY LENGTH(EMAIL);

-----------------------------------------------------------------

-- INSTR(컬럼명 | 문자열 , '찾을 문자열' [, 찾기 시작할 위치 [, 순번]]) : 지정한 위치부터 지정한 순번대로 검색되는 문자의 위치를 반환

-- 문자열을 앞에서부터 검색하여 첫번째 B의 위치를 조회
-- AABAACAABBAA
SELECT INSTR('AABAACAABBAA','B') FROM DUAL;

-- 문자열을 5번째 문자부터 검색하여 첫번째 B의 위치 조회
SELECT INSTR('AABAACAABBAA','B',5) FROM DUAL;

-- 문자열을 5번째 문자부터 검색하여 2번째 B의 위치 조회
SELECT INSTR('AABAACAABBAA','B',5, 2) FROM DUAL;

-- EMPLOYEE 테이블에서 사원명, 이메일, 이메일 중 '@' 위치 조회
SELECT EMP_NAME, EMAIL, INSTR(EMAIL,'@') FROM EMPLOYEE;

--------------------------------------------------------------------

-- SUBSTR('문자열'|'컬럼명', 잘라내기 시작할 위치[,잘라낼 길이]) 
-- 컬럼이나 문자열에서 지정한 위치부터 지정된 길이만큼 문자열을 잘라내서 반환
--> 잘라낼 길이 생략 시 끝까지 잘라냄

-- EMPLOYEE 테이블에서 사원명, 이메일 중 아이디만 조회
-- EX)sun_di@or.kr -> sun_di

SELECT EMP_NAME 이름, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) 아이디 FROM EMPLOYEE;

-----------------------------------------------------------------------

-- TRIM( [옵션 '문자열' | 컬럼명 FROM] '문자열'|'컬럼명' )
-- 주어진 컬럼이나 문자열의 앞, 뒤, 양쪽에 있는 지정된 문자를 제거
--> 양쪽 공백 제거에 많이 사용함

-- 옵션 : 	(앞쪽), TRAILING(뒤쪽), BOTH(양쪽, 기본값)
SELECT TRIM('         H E L L O         ') FROM DUAL; -- 양쪽 공백 제거

SELECT TRIM(TRAILING  '#' FROM '####안녕####') FROM DUAL;

----------------------------------------------------------------------------

-- 숫자 관련 함수

-- ABS(숫자 | 컬럼명) : 절대값
SELECT ABS(10), ABS(-10) FROM DUAL;

SELECT '절대값 같음' FROM DUAL WHERE ABS(10) = ABS(-10); -- WHERE절 함수 작성 가능


-- MOD(숫자 | 컬럼명, 숫자 | 컬럼명) : 나머지값 반환

-- EMPLOYEE 테이블에서 사원의 월급은 100만으로 나눴을 때 나머지 조회

SELECT EMP_NAME, SALARY, MOD(SALARY, 1000000) FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사원이 짝수인 사원의 사번, 이름조회
SELECT EMP_ID, EMP_NAME, MOD(EMP_ID, 2) FROM EMPLOYEE WHERE MOD(EMP_ID, 2) = 0;

-- EMPLOYEE 테이블에서 사원이 홀수인 사원의 사번, 이름조회
SELECT EMP_ID, EMP_NAME, MOD(EMP_ID, 2) FROM EMPLOYEE WHERE MOD(EMP_ID, 2) != 0;

-- ROUND(숫자 | 컬럼명 [, 소수점 위치]) : 반올림
SELECT ROUND(123.456) FROM DUAL;

SELECT ROUND(123.456, 1) FROM DUAL;
-- 123.5 소수점 두번째 자리에서 반올림(소수점 첫번째 자리까지 표기)

SELECT ROUND(123.456, 0) FROM DUAL;
-- 소수점 첫번째 자리에서 반올림(소수점 표기 안함)

-- CEIL(숫자 | 컬럼명) : 올림
-- FLOOR(숫자 | 컬럼명) : 내림
--> 둘 다 소수점 첫째 자리에서 올림/내림 처리

SELECT  CEIL(123.1), FLOOR(123.9) FROM DUAL;

-- TRUNC(숫자 | 컬럼명[, 위치]) : 특정 위치 아래를 절삭
SELECT TRUNC(123.456, 1) FROM DUAL; -- 소수점 첫째자리 아래 절삭

SELECT TRUNC(123.456, -1) FROM DUAL; -- 10의자리 아래 절삭


----------------------------------------------------------------------------------------------

/* 날짜(DATE) 관련 함수 */

-- SYSDATE : 시스템에 현재 시간(년, 월, 일, 시, 분, 초)을 반환
SELECT SYSDATE FROM DUAL;

-- SYSTIMETAMP : DYSDATE + MS 단위 추가
SELECT SYSTIMESTAMP FROM DUAL;

-- MONTHS_BETWEEN(날짜, 날짜) : 두 날짜의 개월 수 차이 반환
SELECT ABS(ROUND (MONTHS_BETWEEN(SYSDATE, '2025-01-23'), 3)) " 수강 기간 개월 " FROM DUAL;


-- EMPLOYEE 테이블에서
-- 사원의 이름, 입사일, 근무한 개월 수, 근무 년차 조회

SELECT EMP_NAME, HIRE_DATE,
CEIL(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)) "근무한 개월수",
CEIL(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) || '년차' "근무 년차"  
FROM EMPLOYEE;

/* || : 연결 연산자(문자열 이어쓰기) */

-- ADD_MONTHS(날짜, 숫자) : 날짜에 숫자 만큼의 개월 수를 더함. (음수도 가능)
SELECT ADD_MONTHS(SYSDATE, 4) FROM DUAL; 
SELECT ADD_MONTHS(SYSDATE, -1) FROM DUAL; 

-- LAST_DAY(날짜) : 해당 달의 마지막 날짜를 구함
SELECT LAST_DAY(SYSDATE) FROM DUAL; 
SELECT LAST_DAY('2020-02-01') FROM DUAL; 


-- 직원의 급여를 인상하려고 한다.
-- 직급 코드가 J7인 직원은 20% 인상,
-- 직급 코드가 J6인 직원은 15% 인상,
-- 직급 코드가 J5인 직원은 10% 인상,
-- 그 외 직급은 5% 인상.
-- 이름, 직급코드, 급여, 인상률, 인상된 급여를 조회

SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE(JOB_CODE, 'J7', '20%' , 'J6', '15%', 'J5', '10%', '5%') 인상률,
DECODE(JOB_CODE, 'J7', SALARY * 1.2, 'J6', SALARY * 1.15, 'J5', SALARY * 1.1, SALARY * 1.05) "인상된 급여"
FROM EMPLOYEE;

-- CASE WHEN 조건식 THEN 결과값
--      WHEN 조건식 THEN 결과값
--      ELSE 결과값
-- END

-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과값을 반환
-- 조건은 범위 값 가능

-- EMPLOYEE 테이블에서 급여가 500만원 이상이면 '대'
-- 급여가 300만원 이상 500만원 미만이면 '중'
-- 급여가 300만원 미만이면 '소'

SELECT EMP_NAME, SALARY, CASE WHEN SALARY >= 5000000 THEN '대' WHEN SALARY >= 3000000 THEN '중' ELSE '소' END "급여 받는 정도" FROM EMPLOYEE;


------------------------------------------------------------------

-- 그룹 함수

-- 하나 이상의 행을 그룹으로 묶어 연산하여 총합, 평균 등의
-- 하나의 결과 행으로 반환하는 함수

-- SUM(숫자가 기록된 컬럼명) : 합계
-- 모든 직원의 급여 합 조회
SELECT SUM(SALARY) FROM EMPLOYEE;

-- AVG(숫자가 기록된 컬럼명) : 평균
-- 모든 직원의 급여 평균
SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE;

-- 부서 코드가 'D9' 인 사원들의 급여 합, 평균
SELECT SUM(SALARY), ROUND(AVG(SALARY))
FROM EMPLOYEE WHERE DEPT_CODE = 'D9';

-- MIN(컬럼명) : 최소값
-- MAX(컬럼명) : 최대값
--> 타입 제한 없음(숫자 : 대/소, 날짜 : 과거/미래, 문자열 : 문자 순서)

-- 급여 최소값 , 가장 빠른 입사일, 알파벳 순서가 가장 빠른 이메일 조회
SELECT MIN(SALARY), MIN(HIRE_DATE), MIN(EMAIL) FROM EMPLOYEE;

-- 급여 최대값 , 가장 늦은 입사일, 알파벳 순서가 가장 느린 이메일
SELECT MAX(SALARY), MAX(HIRE_DATE), MAX(EMAIL) FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 급여를 가장 많이 받는 사원의
-- 이름, 급여, 직급코드 조회

SELECT EMP_NAME, SALARY, JOB_CODE FROM EMPLOYEE
WHERE SALARY  = (SELECT MAX(SALARY) FROM EMPLOYEE);

-- SELECT MAX(SALARY) FROM EMPLOYEE;
-- 서브쿼리 + 그룹함수
 
-- COUNT() : 행 개수를 헤아려서 리턴
-- COUNT(컬럼명) : NULL을 제외한 실제값이 기록된 행 개수를 리턴
-- COUNT(*) : NULL을 포함한 전체 행 개수를 리턴
-- COUNT(DISTINCT) : 중복을 제거한 행 개수를 리턴함

SELECT COUNT(*) FROM EMPLOYEE;

































