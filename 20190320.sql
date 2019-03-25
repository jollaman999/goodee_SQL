-- 사원테이블 (emp) table 에서 사원명, 직책(job), 급여(salary) 컬럼만 조회하기.
-- 모든 직원을 조회하기
SELECT ename,job,salary from emp;

-- 컬럼에 리터럴을 사용하기
SELECT empno,ename,'사원','오마이갓' FROM emp;

-- 문제 :
-- 1. emp 테이블의 모든 레코드에 empno,ename 컬럼 출력하는 select 구문 작성하기
SELECT '사번',empno,'이름',ename FROM emp;

-- 2. 교수(professor) 테이블, 모든 레코드의 교수이름(name), 교수번호(no) 컬럼 조회하기
SELECT '교수번호',no,'교수이름',name FROM professor;

-- 1
SELECT no 교수번호,name 교수이름 FROM professor;
-- 2
SELECT no "교수 번호", name "교수 이름" FROM professor;
-- 3
SELECT no AS "교수 번호", name AS "교수 이름" FROM professor;

-- 컬럼에 연산자 사용하기
-- 사원의 급여를 10%씩 일괄로 인상하였을때 예상 인상급여 조회하기
SELECT ename 이름,salary 급여,salary * 1.1 인상예상급여 FROM emp;

-- 문제 : 교수테이블에서 교수번호, 교수이름, 현재급여, 5% 인상 예상급여 출력
SELECT no 교수번호, name 교수이름, salary 현재급여, salary * 1.05 "5% 인상 예상급여" FROM professor;

-- 문제 : 교수테이블에서 교수번호(no), 교수이름(name), 현재급여(salary), 연봉 출력하기
-- 단 연봉은 급여*12 로 한다.
SELECT no 교수번호, name 교수이름, salary 현재급여, salary * 12 연봉 FROM professor;

-- distinct : 조회한 컬럼의 중복제거
--            성능에 주의가 필요함.
--            조회되는 컬럼이 여러개여도 처음에 한번만 사용이 가능하다.
-- 교수가 속한 부서코드를 조회하기
SELECT distinct deptno FROM professor;

-- 교수가 속한 직급별 부서코드를 조회하기
SELECT DISTINCT position,deptno FROM professor;

-- emp 테이블에서 사원급여를 10% 일괄 인상했을때 인상예상급여가 1000만원 이상인
-- 사원의 이름, 현재급여, 인상예상급여, 부서코드 조회하기
select ename as 이름, salary as 현재급여, salary * 1.1 as 인상예상급여, deptno as 부서코드 from emp where salary * 1.1 >= 1000;

-- 문제
-- 1. 사원의 급여가 700 이하인 사원들만 급여를 5% 인상하기로 한다.
-- 인상되는 사원의 이름, 현재급여, 인상예상급여, 부서코드 출력하기
-- 2. 학생테이블에서 생일이 1998년 6월 30일 이후에 출생한 학생 중
-- 1학년 학생인, 이름, 학과코드, 생일, 학년 컬럼 조회하기
-- 날짜표시는 '1998-06-30' 한다.

select ename as 이름, salary as 현재급여, salary * 1.05 as "인상 예상 급여", deptno as 부서코드 from emp where salary <= 700;

select name as 이름, major1 as 학과코드, birthday as 생일, grade as 학년 from student where grade = 1 && birthday > '1998-06-30';

-- 2. 학생테이블에서 생일이 1998년 6월 30일 이후에 출생한 학생 이거나
-- 1학년 학생인, 이름, 학과코드, 생일, 학년 컬럼 조회하기
-- 날짜표시는 '1998-06-30' 한다.
select name as 이름, major1 as 학과코드, birthday as 생일, grade as 학년 from student where grade = 1 || birthday > '1998-06-30';

-- between 연산자 사용하기
-- where 컬럼명 between A and B => A값, B값 모두 포함
-- where 컬럼명 >= A and B >= 컬럼명

-- 1학년 학생 중 몸무게가 70이상 80이하인 학생의 이름, 몸무게 출력하기
select name, weight from student where weight between 70 and 80 and grade = 1;
select name, weight from student where weight >= 70 and weight <= 80 and grade = 1;

-- 문제
-- 1. 전공학과가 101인 학생 중 몸무게가 50이상 80이하인 학생의 이름, 몸무게, 전공학과 출력하기.
-- between, 관계연산자 사용하기
select name, weight, major1 from student where major1 = 101 and weight between 50 and 80;

-- 2. 학생 중 2, 3 학년 학생의 학번, 이름, 생일, 학년 출력하기
select major1, name, birthday from student where grade between 2 and 3;

-- in 연산자

-- 학생 중 전공1이 101 학과이거나 201 학과인 학생의 이름, 전공1학과코드, 학년 출력하기
select name, major1, grade from student
where major1 in (101,201);

-- 문제
-- 1. 101,201 전공학과 학생 중 키가 170 이상인 학생의 학번, 이름, 몸무게, 키, 학과코드 조회하기
select studno, name, weight, height, major1 from student where major1 in (101, 201) and height >= 170;

-- 2. 교수 중 학과코드(deptno) 가 101 학과, 201 학과에 속한 교수의 교수번호(no), 이름(name), 학과코드(deptno), 입사일(hiredate)를 조회하기
select no, name, deptno, hiredate from professor where deptno in (101, 201);

-- like
-- % : 0개 이상의 임의의 문자
-- _ : 1개의 임의의 문자

-- 성이 김씨의 학생의 학번, 이름, 학과코드를 조회하기
select studno, name, major1 from student where name like "김%";

-- 학생 중 이름에 진 자가 포함되어 있는 학생의 학번, 이름, 학과코드를 조회하기
select studno, name, major1 from student where name like "%진%";

-- 학생 중 이름이 진으로 끝나는 학생의 학번, 이름, 학과코드를 조회하기
select studno, name, major1 from student where name like "%진";

-- 학생 중 성과 이름이 두 자인 학생의 학번, 이름, 학과코드를 조회하기
select studno, name, major1 from student where name like "__";

-- 문제
-- 1. 학생 중 이름의 끝자가 '훈'인 학생의 학번, 이름, 전공1코드 조회하기
select studno, name, major1 from student where name like "%훈";

-- 2. 학생 중 전화번호가 서울 지역인 학생의 학번, 이름, 전화번호 조회하기
select studno, name, tel from student where tel like "02%";

-- 3. 학생 중 id의 글자수가 8자인 학생의 학번, 이름, id, 학년 조회하기
select studno, name, id, grade from student where id like "________";
select studno, name, id, grade from student where length(id) = 8;

-- not like
-- 학생 중 성이 이씨가 아닌 학생의 학번, 이름, 학과코드 조회하기
select studno, name, major1 from student where name not like "이%";

-- is null, is not null 연산자
-- null의 의미는 값이 없다.
-- 연산또는 비교의 대상이 아니다.
-- 교수 테이블 중 보너스가 없는 교수의 이름, 급여, 보너스 출력하기
select name, salary, bonus from professor where bonus is null;

-- 교수 테이블 중 보너스가 없는 교수들의 이름, 보너스, 연봉 출력하기
-- 연봉은 (급여 * 12) + 보너스
select name, bonus, (salary * 12) + ifnull(bonus, 0) from professor where bonus is null;

-- 사원 중 보너스가 있는 사원의 사원번호, 이름, 급여, 보너스를 출력하기
select empno, ename, salary, bonus from emp where bonus is not null;

-- binary 예약어 사용하기
-- 교수테이블에서 id 컬럼에 k가 존재하는 교수의 이름, id, 직책을 출력하기.
select name, id, position from professor where id like "%K%";
-- ==> like 대소문자 구분이 안됨.
select name, id, position from professor where id like binary "%k%";
-- ==> binary에 의해 대소문자 구분이 됨.

-- 정렬하기 : order by 구문
/*
  select *||컬럼1,컬럼2,...
  [from 테이블명|뷰명]
  [where 조건문]
  [group by 컬럼명]
  [having 조건문]
  [order by 컬럼명||컬럼순서||별명 (desc|asc)] => select 구문의 마지막에 구현되어야 함.
*/
-- 1학년 학생의 이름과 키를 출력하기. 단 키순으로 출력
select name, height from student where grade = 1 order by height;

-- 1학년 학생의 이름과 키를 출력하기. 단 키가 큰 순으로 출력
select name, height from student where grade = 1 order by height desc;

select name, height from student where grade = 1 order by 2;

select studno,name, height from student where grade = 1 order by 3;

select * from student where grade = 1 order by 8;

select name 이름, height 키 from student where grade = 1 order by 키;

-- 사원 테이블에서 10% 인상 예상급여를 출력하기.
-- 사원이름, 현재급여, 인상예상급여 출력하기
-- 단, 인상예상급여의 내림차순으로 정렬하기.
select ename, salary, salary * 1.1 as 인상예상급여 from emp order by 인상예상급여 desc;

-- 학생들의 이름, 학년, 키를 학년 순으로 키가 큰 순으로 정렬
select name, grade, height from student order by grade, height desc;

-- 문제
-- 1. 교수테이블에서 교수번호, 이름, 학과코드, 급여, 예상급여(10% 인상) 조회하기.
-- 단, 학과코드 순으로 예상급여의 내림차순으로 조회하기.
select no, name, deptno, salary, salary * 1.1 as 예상급여 from professor order by deptno, 예상급여 desc;

-- 2. 학생테이블에서 지도교수(profno)가 배정되지 않은 학생의 학번, 이름, 지도교수번호, 전공1코드를 출력하기.
-- 단, 학과코드 순으로 정렬하기
select studno, name, profno, major1 from student where profno is null order by major1;

-- 3. 1학년 학생의 이름, 키, 몸무게를 출력하기
-- 단, 키는 작은 순으로 몸무게는 큰 순으로 출력하기
select name, height, weight from student order by height desc, weight;

-- Exam
/*
1. emp 테이블에서 empno는 사원번호로, ename 사원명, job는 직급으로 별칭을 
    설정하여  출력하기 
*/
select empno as "사원번호", ename as "사원명", job as "직급" from emp;

/*
 2. dept 테이블에서 deptno 부서#, dname 부서명, loc 부서위치로 별칭을 설정하여 
   출력하기 :
*/
select deptno as "부서#", dname as "부서명", loc as "부서위치" from dept;

/* 3. 학생을 담당하는 지도교수번호를 출력하기  */
select distinct profno from student where profno is not null order by profno;

/* 4. 현재 교수들에게 설정된 직급을 출력하기 */
select distinct position from professor;
 
/* 5. 학생테이블에서 name, birthday,height,weight 컬럼을 출력하기
   단 name은 이름, birthday는 생년월일 ,height 키(cm),weight 몸무게(kg) 으로 
   변경하여 출력하기 : */
select name as "이름", birthday as "생년월일", height as "키(cm)", weight as "몸무게(kg)" from student;

/* 6. 학생의 생일이 96년12월31일 이후인 학생의 학번 ,이름, 생일을 출력하기*/
select studno, name, birthday from student where birthday > "1996-12-31";

/*
 7. 전공1이 101번,201 학과의 학생 중 몸무게가 50이상 80이하인 학생의 
    이름(name), 몸무게(weight), 학과코드(major1)를 출력하기 : */
select name, weight, major1 from student where major1 in (101, 201) && weight between 50 and 80 order by major1, weight;

/*
 8.학생 테이블에 1학년 학생의 이름과 주민번호기준생일, 키와 몸무게를 출력하기. 
   단 생일이 빠른 순서대로 정렬 */
select name, jumin, height, weight from student order by jumin;

select name, substr(jumin, 1, 6), height, weight from student where grade = 1 order by 2;

/* 9. 교수테이블(professor)급여가 300 이상이면서 보너스(bonus)을 받거나 
   급여가 450 이상인 교수 이름, 급여, 보너스을 출력하여라. */
select name, salary, bonus from professor where (salary >= 300 && bonus is not null) || salary >= 450 order by salary, bonus;

/* 10. 학생 중 전화번호가 서울지역이 아닌 학생의 학번, 이름, 학년, 전화번호를 출력하기
    단 학년 순으로 정렬하기 */
select studno, name, grade, tel from student where tel not like "02%" order by grade;

/*
1. 테이블의 구조 : desc 테이블명
2. select 컬럼명|| * from 테이블명
   where 조건문 => 레코드의 선택 조건
                   where 조건문 구문이 없는 경우 모든 레코드 선택
   order by 컬럼명 || 컬럼의순서 || 별명
3. 리터럴 문자를 컬럼으로 사용 가능함.
   컬럼명의 별명을 부여 할 수 있다.
   컬럼에 연산자 사용 가능함.
   중복제거 => distinct
4. where
   관계연산자 (=, >, < ......, and, or)
   between A and B
   in : 컬럼명 in (값1, 값2 ...) => or 조건
   like : % : 0개 이상의 임의의 문자
          _ : 1개의 임의의 문자
   is null, is not null : null은 값은 없기 때문에 연산할 수 없다.
5. order by
   정렬방식 설정
   asc : 오름차순 정렬, 기본 정렬 벙식, 생략 가능
   desc : 내림차순 정렬, 생략 불가
   order by : 컬럼1, 컬럼2
            => 1차 정렬 컬럼1 하고, 2차 정렬 컬럼2를 기준으로 함.
*/

-- 집합연산자 : union, union all => 합집합
-- union : 중복 제거 합집합
-- union all : 두개의 조회 결과를 합하여 출력함.
-- 주의 : 두개의 구문이 컬럼의 수가 같아야 함.
-- 전공1 학과가 202 학과 이거나, 전공2 학과가 101인 학생의 학번, 이름, 전공1, 전공2 조회하기
select name, major1, major2 from student where major1 = 202

select name, major1, major2 from student where major1 = 202
union all
select name, major1, major2 from student where major2 = 101;

-- 학생 중 전공1학과가 101번 학과 학생의 학번, 이름, 전공1코드와
-- 교수 중 101번 학과의 교수번호, 이름, 학과 코드 출력하기
select '학생' 구분, studno, name, major1 from student where major1 = 101
union
select '교수' 구분, no, name, deptno from professor where deptno = 101;

-- 문제
-- 1. 교수 중 급여가 450 이상인 경우는 5% 인상 예정이고, 450 미만인 경우는
--    10% 인상 예정이다. 교수번호, 교수이름, 현재급여, 인상예정급여 출력하기
--    인상예상급여가 큰 순으로 출력하기
select no, name, salary, salary * 1.05 as "인상예상급여" from professor where salary >= 450
union
select no, name, salary, salary * 1.1 from professor where salary < 450 order by 4 desc;

-- 2. 교수 중 보너스가 있는 교수의 연봉은 급여 * 12 + 보너스 이고
-- 보너스가 없는 교수의 연봉은 급여 * 12 로 한다.
-- 교수번호, 교수이름, 급여, 보너스, 연봉을 출력하기
-- 연봉순으로 출력하기
select no, name, salary, bonus, salary * 12 as "연봉" from professor where bonus is null
union
select no, name, salary, bonus, salary * 12 + bonus from professor where bonus is not null order by 5;

/*
함수
 단일행함수 : 하나의 레코드만 영향
 그룹함수 : 여러행에 관련된 기능 조회
*/

-- 문자함수 : 문자열에 사용되는 함수
-- 대소문자 변환
--   upper, lower
-- 학과번호가 101번 학생인 학생의 이름, id, 대문자 id, 소문자 id 출력하기
select name, id, upper(id), lower(id) from student
where major1 = 101;

-- 문자열의 길이 :
--   length : 글자가 저장되는 바이트수 => 한글 한자는 3바이트 계산
--   char_length : 글자 수 :
-- 학생의 이름, 아이디, 이름의 글자 수, 이름의 바이트수를 출력
select name, id, char_length(name), length(name) from student;

-- 문자열 연결 함수
-- concat => 컬럼을 연결하기
-- 교수의 이름과 직급을 연결하기
select name, position from professor;
select concat(name, "=", position) from professor;

-- 문제
-- 학생의 이름 학년을 연결하여 출력하기. 연결컬럼과 키 몸무게 출력하기
-- 예) 홍길동1학년 150cm 50kg
select concat(name, grade, "학년 ") as "학생", concat(height, "cm ") as "키", concat(weight, "kg") as "몸무게" from student;

-- 부분문자열
-- substr(컬럼명, 시작인덱스, 글자수)
-- left(컬럼명, 길이) : 왼쪽부터 길이만큼 부분 문자열
-- right(컬럼명, 길이) : 오른쪽부터 길이만큼 부분 문자열

-- 학생의 이름만 조회하기
select right(name, 2) from student;

-- 학생의 주민번호 기준 생일부분만 조회하기
select name, left(jumin, 6) from student;
select name, substr(jumin, 1, 6) from student;

-- 학생 중 생일이 3월인 학생의 이름과 생일 출력하기.
-- 단 생일은 주민번호 기준.
select name, left(jumin, 6) from student where substr(jumin, 3, 2)="03";

-- 문제
-- 1. 학생의 id 길이가 7개 이상 10개 이하인 id를 가진
--  학생의 학번, 이름, id, id의 글자수 출력하기
select studno, name, id, char_length(id) from student where char_length(id) between 7 and 10;

-- 2. 교수 중 교수의 성이 ㅈ이 포함된 교수의 이름을 출력하기
select name from professor where left(name, 1) between "자" and "찧";

-- 3. 학생의 생년월일은 98년 03월 20일의 형식으로 이름, 생년월일, 학년을 출력하기.
-- 단, 생년월일은 주민번호 기준으로 하고,
-- 생년월일의 월로 정렬하여 출력하기.
select name, concat(substr(jumin, 1, 2), "년 ", substr(jumin, 3, 2), "월 ", substr(jumin, 5, 2), "일") as birthday, grade from student order by substr(jumin, 3, 2);

-- 문자열의 위치 : instr
--  instr(컬럼, 문자)
-- 학생테이블에서 이름, 전화번호, ) 문자의 위치를 출력하기
select name, tel, instr(tel, ')') from student;

-- 문제
-- 1. 학생의 이름, 전화번호, 지역번호를 출력하기
select name, tel, left(tel, instr(tel, ')') - 1) as 지역번호 from student;

-- 2. 교수의 이름, url, homepage, homepage의 길이 출력하기
-- homepage는 url에서 http:// 이후의 문자를 받는다.
select name, url, substr(url, char_length("http://") + 1, char_length(url) - char_length("http://")) as homepage,
char_length(url) - char_length("http://") as "char_length(homepage)"
from professor;

-- 문자 추가함수
-- lpad : 왼쪽에 문자를 채움, lpad(컬럼, 전체자리수, 채울문자)
-- rpad : 오른쪽에 문자를 채움, rpad(컬럼, 전체자리수, 채울문자)
-- 학생의 이름과, id, id를 15자리로 출력하는데 왼쪽을 $로 채우고,
-- 오른쪽을 *로 채우기
select name, id, lpad(id, 15, '$'), rpad(id, 15, '*') from student;

-- 학생의 학번과 이름 출력하기. 학번은 10자리로 빈자리는 오른쪽에 *로
-- 채워 출력하기
select rpad(studno, 10, '*'), name from student;

-- 교수의 이름과 직급 출력하기 직급 12자리로 빈자리는 오른쪽에 *로 출력
select name, rpad(position, 12, '*') from professor;

-- 문자 제거 함수 : trim, rtrim, ltrim
-- 000120000056700000 문자의 양쪽 0을 제거하기
-- 양쪽 0 제거
select trim(both '0' from '000120000056700000');
-- 오른쪽 0 제거
select trim(trailing '0' from '000120000056700000');
-- 왼쪽 0 제거
select trim(leading '0' from '000120000056700000');

-- 교수테이블에서 url 컬럼의 http:// 문자를 제거하여 출력하기
select trim(leading 'http://' from url) from professor;

select ltrim('     왼쪽 공백 제거          ') ltrim;
select rtrim('      오른쪽 공백 제거       ') rtrim;
select trim('       양쪽 공백 제거        ') trim;
select ltrim(rtrim('         양쪽 공백 제거        ')) trim;
select trim(both ' ' from '          양쪽 공백 제거       ') trim;

-- 문자 치환 함수 : replace
-- replace(컬럼, '문자1', '문자2') : 컬럼에서 문자1을 문자2로 변경
-- 학생의 이름을 성만 #문자로 치환해서 출력하기
select name, replace(name, left(name, 1), '#') from student;
select name, concat('#', substr(name, 2)) from student;

-- 문제
-- 101학과 학생의 이름과 주민번호 출력하기
-- 단 주민번호의 뒤 6자리를 *로 출력하기
select name, replace(jumin, right(jumin, 7), '******') from student where major1 = 101;

-- 그룹 문자열의 위치 검색 : find_in_set
select find_in_set('y', 'x,y,z');
select find_in_set('홍길동', '홍길동,김삿갓,이몽룡');
select find_in_set('이몽룡', '홍길동,김삿갓,이몽룡');
select find_in_set('임꺽정', '홍길동,김삿갓,이몽룡');

-- 문제
-- 학생 중 이름이 2자인 학생의 이름과 학년, 전공코드 조회하기
select name, grade, major1 from student where name like '__';
select name, grade, major1 from student where char_length(name) = 2;

-- 숫자 함수
-- 반올림 함수
-- round(숫자) : 소숫점 이하 첫째 자리에서 반올림.
-- round(숫자, 숫자) : 소숫점 이하 숫자 자리에서 반올림.
select round(12.3456, -1) r1,
       round(12.3456) r2, round(12.3456, 0) r21, round(12.3456, 1) r3,
       round(12.3456, 2) r4, round(12.3456, 3) r5;

-- 버림 함수
-- truncate(숫자, 숫자) : 소숫점 이하 숫자 자리까지 반올림.
select truncate(12.3456, -1) r1,
       truncate(12.3456, 0) r21, truncate(12.3456, 1) r3,
       truncate(12.3456, 2) r4, truncate(12.3456, 3) r5;

-- 문제
-- 교수의 급여를 15% 인상하여 정수로 출력하기
-- 교수이름, 현재급여, 반올림 된 예상 급여, 절삭된 예상급여 출력하기
select name, salary, round(salary * 1.15), truncate(salary * 1.15, 0) from professor;

-- score 테이블에서 학생의 학번, 국어(kor), 영어(eng), 수학(math),
-- 총점, 평균 출력하기
-- 단, 평균은 소숫점 이하 2자리 까지만 출력
-- 총점의 내림차순으로 정렬
select studno, kor, eng, math, (kor + eng + math) as sum, round(kor + eng + math /3, 2) as avg from score order by sum;

-- 근사 정수
-- ceil : 큰 근사 정수
-- floor : 작은 근사 정수
select ceil(12.3456), floor(12.3456);

-- 나머지 : mod
select mod(21, 8);

-- 제곱 : power
select power(3, 3);

/*
날짜 관련 함수
*/
-- 현재 날짜 : now(), curdate(), current_date, current_date()
      오라클 : sysdate 예약어
select now(), curdate(), current_date, current_date();
select sysdate();

-- 날짜 사이의 일자수 알기
-- datediff
select now(), '2019-01-01', datediff(now(), '2019-01-01');
select datediff('2019-03-22', '2019-03-21');
select datediff('2019-03-21', '2019-03-22');

-- 2018년 1월 1일 부터 현재까지의 날짜를 출력하기
select datediff(now(), '2018-01-01');
select datediff(current_date, '2018-01-01');
select datediff(current_date(), '2018-01-01');

-- 학생의 이름과 생일, 학생의 생일부터 현재 까지의 일수를 출력하기
select name, birthday, datediff(now(), birthday) from student;

select "임수현", datediff(now(), "1992-07-23");

-- 문제
-- 1. 학생의 이름과 생일, 현재 까지의 개월 수와 나이를 출력하기
-- 개월수 일수/30 나누어 계산, 나이는 일수 / 365 나누어 계산
-- 개월수와 나이는 반올림하여 정수로 출력하기
select name, birthday, round(datediff(now(), birthday) / 30) "개월 수", round(datediff(now(), birthday) / 365) "나이" from student;

-- 2. 교수의 이름과, position, hiredate, 입사개월수, 입사년수 출력하기
-- 입사개월수는 일수/30 나누어 계산, 입사년수는 일수/365 나누어 계산
-- 입사개월수, 입사년수는 절삭하여 정수로 출력
select name, position, hiredate, truncate(datediff(now(), hiredate) / 30, 0) "입사개월 수", truncate(datediff(now(), hiredate) / 365, 0) "입사년 수" from professor;

/*
  year : 년도
  month : 월
  day : 일
  weekday : 요일, 0 : 월요일, 1 : 화요일 ... 6 : 일요일
  dayofweek : 요일, 1 : 일요일, 2 : 월요일 ... 7 : 토요일
  week : 일년 중 몇번 째 주
  last_day : 해당월의 마지막 일자
*/
select year(now()), month(now()), day(now()), weekday(now()),
       dayofweek(now()), week(now()), last_day(now());

-- 문제
-- 교수이름, 입사일, 올해의 휴가보상일 출력하기
-- 휴가보상일 입사월의 마지막 일자
select name, hiredate, last_day(concat(year(now()), "-", substr(hiredate, 6))) "휴가보상일" from professor;

/*
1. 학생 테이블에서 id에 kim 이 있는 학생의 학번, 이름, 학년, id 를 출력하기.  
   단 kim은 대소문자를 구분하지 않는다.
*/
select studno, name, grade, id from student where id like "%kim%";

select studno, name, grade, id from student where id like binary "%kim%"; -- => 대소문자 구분

select studno, name, grade, id from student where lower(id) like "%kim%"; -- => 함수를 이용하여 소문자 변경

/*
2. 교수테이블에서 보너스가 없는 교수의 교수번호, 이름, 급여, 10% 인상급여를 출력하고
   보너수가 있는 교수는 의 급여는 인상되지 않도록 인상 예상급여를 출력하기
   단 인상급여의 내림차순으로 정렬하기
*/
select no, name, salary as "인상급여" from professor where bonus is null
union
select no, name, salary * 1.1 from professor where bonus is not null order by 3;

/* 3. 학생 중 이름의 끝자가 '훈'인 학생의 학번, 이름, 전공1코드 출력하기 */
select studno, name, major1 from student where name like "%훈";

/* 4. 학생의 학번, 이름, id, id중 첫자는 대문자로 나머지는 소문자로 출력하기 */
select studno, name, concat(upper(left(id, 1)), lower(substr(id, 2))) as id from student;

/*
5. 교수테이블에서 교수이름, url, homepage, homepage의 길이를 출력하기. 
   단 url이  있는 교수만 출력하기
   homepage :  http://www.goodee.co.kr => www.goodee.co.kr */
select name, url, substr(url, char_length("http://") + 1) as homepage from professor where url is not null;

select name, url, trim(leading "http://" from url) homepage,
char_length(trim(leading "http://" from url)) length
from professor where url is not null;

/*
6. 교수 테이블에서 입사일이 1-3월인 모든 교수의  급여를 15% 인상하여 정수로 출력하되
  반올림된 값과 절삭된 값을  출력하기.
*/
select name, salary, round(salary * 1.15) as "반올림된 인상급여",
truncate(salary * 1.15, 0) as "절삭된 인상급여", hiredate from professor where month(hiredate) between "01" and "03";

select name, salary, round(salary * 1.15) as "반올림된 인상급여",
truncate(salary * 1.15, 0) as "절삭된 인상급여", hiredate from professor where month(hiredate) <= 3;

select name, salary, round(salary * 1.15) as "반올림된 인상급여",
truncate(salary * 1.15, 0) as "절삭된 인상급여", hiredate from professor where substr(hiredate, 6, 2) <= "03";

/*
7. 교수들의 근무 개월 수를 현재 일을 기준으로  계산하되,  근무 개월 순으로 정렬하여 출력하기. 
    단, 개월 수의 소수점 이하 버린다 */
select name, truncate(datediff(now(), hiredate) / 30, 0) as "근무 개월 수" from professor order by 2;

/* 8. 사용자 아이디에서 문자열의 길이가 7이상인  학생의 이름과  사용자 아이디를 출력 하여라 */
select name, id from student where char_length(id) >= 7;

/* 9. 교수테이블에서 이름과, 교수가 사용하는 email  서버의 이름을    출력하라. 이메일 서버는 @이후의 문자를 말한다. */
select name, substr(email, instr(email, '@') + 1) as "서버" from professor;

/* 10. 101번학과, 201번, 301번 학과 교수의 이름과   id를 출력하는데,
id는 오른쪽을 $로 채운 후  20자리로 출력하고  동일한 학과의 학생의  이름과 id를 출력하는데,
학생의 id는 왼쪽#으로 채운 후 20자리로 출력하라. */
select name, rpad(id, 20, '$') as id from professor where deptno in (101, 201, 301)
union
select name, lpad(id, 20, '#') as id from student where major1 in (101, 201, 301);


-- 집합연산자 => 합집합
-- union : 중복제거
-- union all : 두개의 결과를 붙여서 출력
--  => 두개 결과의 컬럼의 수가 동일 해야 함.

-- 함수 : 단일형 함수, 그룹함수
-- 단일형 함수
-- 문자열 관련 함수
   -- 대소문자 변경 : upper(컬럼명), lower(컬럼명)
   -- 문자열 연결 : concat(컬럼들, ...)
   -- 문자열 길이 : length : 바이트 수를 리턴 해주는 함수
                 -- char_length : 문자열의 갯수 리턴
   -- 부분문자열 : substr, left, right
                 -- substr(컬럼명, 시작인덱스, [갯수])
                 -- left(컬럼명, 갯수) : 왼쪽부터 갯수만큼
                 -- right(컬럼명, 갯수) : 오른쪽부터 갯수만큼
   -- 문자의 위치 : instr(컬럼, 문자) : 컬럼에서 문자의 인덱스 리턴
   -- 문자를 추가 : lpad(컬럼, 전체자리수, 채울문자) : 반자리 왼쪽 채움
                 -- rpad(컬럼, 전체자리수, 채울문자) : 빈자리 오른쪽 채움
   -- 문자를 제거 : trim, rtrim, ltrim
                 -- trim(leading|trailing|both 문자열 from 컬럼명)
                 -- trim(컬럼) : 양쪽에 공백 제거
                 -- rtrim(컬럼) : 오른쪽 공백 제거
                 -- ltrim(컬럼) : 왼쪽 공백 제거
   -- 문자 치환 : replace(컬럼명, 문자1, 문자2)
                 -- => 컬럼의 값 중 문자1 -> 문자2 치환
   -- 그룹위치 : find_in_set(문자, 문자열그룹)
                 -- 문자열 그룹은 ,로 이루어진 문자열
                 -- 문자 몇번째 그룹인지 번호를 리턴

-- 숫자 관련 함수
   -- 반올림 : round(컬럼, [소숫점이하자리수])
   -- 버림 : truncate(컬럼, 소숫점이하자리수)
   -- 나머지 : mod(숫자1, 숫자2) : 숫자1%숫자2
   -- 제곱 : power(숫자1, 숫자2) : 숫자1의 숫자2 제곱
-- 날짜 관련 함수
   -- 현재날짜 : now(), curdate(), current_date, current_date()
          -- 시간포함 : now()
   -- 일자 수 계산 : datediff(날짜1, 날짜2)
          -- 날짜1 - 날짜2 일자 수 리턴
   -- 일자 구분
          -- year(), month(), day()
          -- weekday() : 0(월)부터
			 -- dayofweek() : 1(일)부터
			 -- week() : 일년 중 몇번째 주
			 -- last_day(날짜) : 그 달의 마지막 날짜

-- 현재 시점 기준 이전 이후
-- date_add : 기준일 이후 시점
-- date_sub : 기준일 이전 시점

-- 현재 시간 기준 1일 이후
select now(), date_add(now(), interval 1 day);
-- 현재 시간 기준 1일 이전
select now(), date_sub(now(), interval 1 day);

-- 현재 시간 기준 1시간 이후
select now(), date_add(now(), interval 1 hour);
-- 현재 시간 기준 1분 이후
select now(), date_add(now(), interval 1 minute);
-- 현재 시간 기준 1초 이후
select now(), date_add(now(), interval 1 second);
-- 현재 시간 기준 1달 이후
select now(), date_add(now(), interval 1 month);
-- 현재 시간 기준 1년 이후
select now(), date_add(now(), interval 1 year);
-- 현재 시간 이후 3일 후
select now(), date_add(now(), interval 3 day);
-- 현재 시간 이후 10일 이후 날짜의 마지막 날짜
select now(), last_day(date_add(now(), interval 10 day));

-- 문제
-- 1. 교수의 정식 입사일은 입사일의 3개월 이후다.
--- 교수의 번호, 이름, 입사일, 정식 입사일 출력하기
select no, name, hiredate, date_add(hiredate, interval 3 month) as "정식 입사일" from professor;

-- 2. 사원의 정식 입사일은 입사일의 2개월 이후 다음달 1일로 한다.
-- 사원의 사원번호, 이름, 입사일, 정식 입사일 출력하기
select empno, ename, hiredate, date_add(last_day(date_add(hiredate, interval 2 month)), interval 1 day) as "정식 입사일" from emp;

-- 날짜를 문자열 변환 : date_format (오라클 : to_char)
-- 문자를 날짜로 변환 : str_to_date (오라클 : to_date)
/*형식 지정 문자
 %Y : 4자리 년도
 %m : 2자리 월
 %d : 2자리 일
 %h : 1 ~ 12시
 %H : 0 ~ 23시
 %i : 0 ~ 59분
 %s : 0 ~ 59초
 %a : 요일
 %W : 요일 (Full)
 %p : AM, PM
 */
select date_format(now(), '%Y년 %m월 %d일 %h:%i:%s'),
       date_format(now(), '%Y년 %m월 %d일 %h:%i:%s %p'),
       date_format(now(), '%Y년 %m월 %d일 %h:%i:%s %a'),
       date_format(now(), '%Y년 %m월 %d일 %h:%i:%s %W');
select str_to_date('20190101', '%Y %m %d');
select date_format(str_to_date('20190101', '%Y%m%d'), '%Y년 %m월 %d일');

-- 기타 함수 :
-- ifnull(컬럼, 기본값) : 컬럼의 값이 null인 경우 기본값으로 변환
-- 교수의 이름과, 직책, 급여, 보너스를 출력하기
-- 단, 보너스 없는 경우 0으로 출력
select name, position, salary, ifnull(bonus, 0) from professor;

-- 교수의 이름과, 직책, 급여, 보너스를 출력하기
-- 단, 보너스 없는 경우 bonus없음 으로 출력
select name, position, salary, ifnull(bonus, "bonus없음") from professor;

-- 교수의 이름과, 직책, 연봉 출력하기
-- 연봉은 급여 * 12 + bonus 로 한다. 단, bonus 가 없는 경우는 급여 * 12 로 한다.
select name, position, salary * 12 + ifnull(bonus, 0) as "급여" from professor;

-- 문제
-- 1. 학생의 이름과 지도교수 번호를 출력하기
-- 단, 지도교수가 없는 경우 '9999'로 출력함
select name, ifnull(profno, '9999') from student;

-- 2. major 테이블에서, 코드, 전공명, build 출력하기
-- build의 값이 null인 경우 '단독 건물 없음'으로 출력하기
select code, name, ifnull(build, '단독 건물 없음') from major;

/*
조건함수
   if : if(조건문, '참', '거짓')
*/
-- 교수의 이름, 학과번호, 학과명 출력하기
-- 단, 학과명은 101학과인 경우 '컴퓨터공학' 나머지는 '공란' 출력하기
select name, deptno, if (deptno = 101, '컴퓨터공학', ' ') as "학과명" from professor;

-- 교수의 이름, 학과번호, 학과명 출력하기
-- 단, 학과명은 101학과인 경우 '컴퓨터공학' 나머지는 '그외 학과' 출력하기
select name, deptno, if (deptno = 101, '컴퓨터공학', '그외 학과') as "학과명" from professor;

-- 교수의 이름, 학과번호, 학과명 출력하기
-- 단, 학과명은 101학과인 경우 '컴퓨터공학'
--              102 학과인 경우 '멀티미디어공학'
--              201 학과인 경우 '기계공학'
--              나머지는 '공란' 출력하기
select name, deptno, if (deptno = 101, '컴퓨터공학', if (deptno = 102, '멀티미디어공학', if (deptno = 201, '기계공학', ' '))) as "학과명" from professor;

-- 문제
-- 1. 학생의 주민번호 7번쨰 자리가 1, 3 인 경우 남자로,
--    2, 4 인 경우 여자로, 그외는 주민번호 오류로 성별 출력하기
select name, jumin, if (substr(jumin, 7, 1) in (1, 3), "남자", if (substr(jumin, 7, 1) in (2, 4), "여자", "주민번호 오류")) as "성별" from student;

-- 2. 학생의 이름, 전화번호, 지역명을 출력하기
--    지역명은 전화번호의 지역번호가 02 : 서울, 051 : 부산, 052 : 울산,
--    그외는 기타로 출력하기
select name, tel, if (left(tel, instr(tel, ')') - 1) = "02", "서울",
                  if (left(tel, instr(tel, ')') - 1) = "051", "부산",
                  if (left(tel, instr(tel, ')') - 1) = "052", "울산", "기타"))) as "지역명"
from student;

/*
조건문 : case 구문
1. case 컬럼 when 값 then 문자
   ....
   else 문자 end
2. case when 조건문 then 문자
   ....
   else 문자 end
*/
-- 학과명이 101 학과인 경우 '컴퓨터공학' 그외 공란으로 출력하기
-- 교수의 이름, 학과코드, 학과명 출력하기
select name, deptno, case deptno when 101 then '컴퓨터공학' else ' ' end as "학과명" from professor;

-- 학과명이 101 학과인 경우 '컴퓨터공학' 그외 기타학과으로 출력하기
-- 교수의 이름, 학과코드, 학과명 출력하기
select name, deptno, case deptno when 101 then '컴퓨터공학' else '기타학과' end as "학과명" from professor;

-- 교수의 이름, 학과번호, 학과명 출력하기
-- 단, 학과명은 101학과인 경우 '컴퓨터공학'
--              102 학과인 경우 '멀티미디어공학'
--              201 학과인 경우 '기계공학'
--              나머지는 '공란' 출력하기
select name, deptno, if (deptno = 101, '컴퓨터공학', if (deptno = 102, '멀티미디어공학', if (deptno = 201, '기계공학', ' '))) as "학과명" from professor;

select name, deptno, case deptno when 101 then '컴퓨터공학'
                                 when 102 then '멀티미디어공학'
                                 when 201 then '기계공학'
                                 else ' ' end as "학과명"
from professor;

-- 문제
-- 1. 학생의 주민번호 7번쨰 자리가 1, 3 인 경우 남자로,
--    2, 4 인 경우 여자로, 그외는 주민번호 오류로 성별 출력하기
select name, jumin, case substr(jumin, 7, 1) when 1 then "남자"
                                             when 3 then "남자"
                                             when 2 then "여자"
														   when 4 then "여자"
                                             else "주민번호 오류" end as "성별"
from student;

select name, jumin, case when substr(jumin, 7, 1) in (1, 3) then "남자"
                         when substr(jumin, 7, 1) in (2, 4) then "여자"
                         else "주민번호 오류" end as "성별"
from student;


-- 2. 학생의 이름, 전화번호, 지역명을 출력하기
--    지역명은 전화번호의 지역번호가 02 : 서울, 051 : 부산, 052 : 울산,
--    그외는 기타로 출력하기
select name, tel, case (left(tel, instr(tel, ')') - 1)) when "02" then "서울"
                  when "051" then "부산"
                  when "052" then "울산"
						else "기타" end as "지역명"
from student;

-- 문제
-- 1. 학생의 생일이 1 ~ 3 월이면 1분기, 4 ~ 5월 2분기
-- 7 ~ 9 월이면 3분기, 10 ~ 12월 4분기라 한다.
-- 학생의 이름, 주민번호, 출생분기를 출력하기.
-- 단, 출생분기는 주민번호 기준으로 한다.
select name, jumin, case when substr(jumin, 3, 2) between "01" and "03"  then "1분기"
                         when substr(jumin, 3, 2) between "04" and "05"  then "2분기"
                         when substr(jumin, 3, 2) between "07" and "09"  then "3분기"
                         when substr(jumin, 3, 2) between "10" and "12"  then "4분기"
                         end as "출생분기"
from student;

-- 2. 학생의 생일이 1 ~ 3 월이면 1분기, 4 ~ 5월 2분기
-- 7 ~ 9 월이면 3분기, 10 ~ 12월 4분기라 한다.
-- 학생의 이름, 주민번호, 출생분기를 출력하기.
-- 단, 출생분기는 생일 기준으로 한다.
select name, birthday, case when substr(birthday, 6, 2) between "01" and "03"  then "1분기"
                            when substr(birthday, 6, 2) between "04" and "05"  then "2분기"
                            when substr(birthday, 6, 2) between "07" and "09"  then "3분기"
                            when substr(birthday, 6, 2) between "10" and "12"  then "4분기"
                            end as "출생분기"
from student;

/*
그룹 함수 : 여러행을 그룹화하여 결과를 리턴
*/
-- count 함수 : 레코드의 건수 리턴. null인 경우 갯수 제외.
-- 교수의 전체 인원수와 교수중 보너스를 받는 교수의 인원수 출력하기
select count(*) 전체인원수, count(bonus) 보너스인원수 from professor;

-- 학생의 전체인원수와 지도교수가 있는 학생의 인원수 출력하기
select count(*) 전체인원수, count(profno) 지도교수 from student;

-- 1학년 학생의 전체 인원수와
-- 1학년 학생 중 지도교수가 있는 학생의 인원수 출력하기
select count(*) 전체인원수, count(profno) 지도교수 from student where grade = 1;

-- 2학년 학생의 전체 인원수와
-- 2학년 학생 중 지도교수가 있는 학생의 인원수 출력하기
select count(*), count(profno) from student
where grade = 2;

-- 학생의 학년별 인원수를 출력하기
select grade, count(*) from student
group by grade;

-- 학생의 전공1별 인원수를 출력하기
select major1, count(*) from student
group by major1;

-- 문제
-- 1. 교수 중 직책별 교수의 인원 수와 보너스를 받고 있는 인원수를 출력하기
select position, count(*), count(bonus) from professor group by position

-- 2. 사원 중 부서별 사원의 인원 수와 보너스를 받고 있는 인원수를 출력하기
select deptno, count(*), count(bonus) from emp group by deptno;

-- 합계 : sum
-- 평균 : avg. null 값은 제외
-- 교수의 급여 합계와 보너스 합계를 조회하기
-- 교수의 급여평균과, 보너스 평균을 조회하기
select sum(salary), sum(bonus), avg(salary), avg(bonus), sum(bonus) / count(*)
from professor;

select sum(salary), sum(bonus), avg(salary), avg(ifnull(bonus, 0)), sum(bonus) / count(*)
from professor;

-- 전체 인원수 출력하기
select count(*), count(ifnull(bonus, 0)) from professor;

-- 교수의 부서별 인원 수, 총 급여 합계, 총 보너스 합계, 급여 평균, 보너스 평균 출력
-- 단, 보너스가 null 인 경우도 평균에 계산되도록 할 것.
select deptno, count(*), sum(salary), sum(bonus), avg(salary), avg(ifnull(bonus, 0)) from professor group by deptno;

-- 교수의 직급별 인원 수, 총 급여 합계, 총 보너스 합계, 급여 평균, 보너스 평균 출력
-- 단, 보너스가 null 인 경우도 평균에 계산되도록 할 것.
select position, count(*), sum(salary), sum(bonus), avg(salary), avg(ifnull(bonus, 0)) from professor group by position;

-- 문제
-- 1. 부서별 교수의 급여, 보너스 합계, 연봉합계,
-- 급여평균, 보너스평균, 연봉평균 출력하기
--    연봉은 급여 * 12 + 보너스로 한다.
-- 단, 보너스가 없는 경우는 0으로 처리함.
-- 평균 출력시 소숫점 2자리로 반올림 하여 출력하기.
select deptno, salary, sum(bonus) "보너스 합계",
sum(salary * 12 + ifnull(bonus, 0)) "연봉합계",
round(avg(salary), 2) "급여평균",
round(avg(ifnull(bonus, 0)), 2) "보너스평균",
round(avg(salary * 12 + ifnull(bonus, 0)), 2) "연봉평균"
from professor
group by deptno;

-- 2. 학생의 학년별 키와 몸무게 평균을 구하기
-- 학년별로 정렬하고, 평균은 소숫점 2자리로 반올림하여 출력하기.
select grade, round(avg(height), 2) "키 평균", round(avg(weight), 2) "몸무게 평균" from student group by grade;

-- 3. score 테이블에서 국어점수합계, 국어평균, 영어점수합계, 영어평균,
-- 수학점수합계, 수학평균, 전체 총점, 전체 평균을 출력하기
select sum(kor), avg(kor), sum(eng), avg(eng), sum(math), avg(math), sum(kor + eng + math),
sum(kor + eng + math) / (count(studno) * 3) from score;

-- having : 그룹함수의 조건문
-- 학생의 학년별 키와 몸무게 평균을 구하고, 평균이 몸무게가 70 이상인
-- 학년을 출력하기
select grade, avg(height), avg(weight) from student group by grade having avg(weight) >= 70;

/*
== select 구문 형식 ==
select 컬럼들 | *
from 테이블명|뷰명
where 레코드를 선택하는 조건문
group by 그룹의 기준이 되는 컬럼명
having 그룹을 선택하는 조건문
order by 정렬의 기준점
*/

/*
1. 사원의 입사 10주년이 되는 년도의 생일의 달 1일부터 한달을  안식월으로 하고자 한다.
   사원의 사원번호, 사원이름, 직급, 부서코드, 안식시작일, 안식종료일을 출력하기 */

select empno, ename, job, deptno,
str_to_date(concat(year(date_add(hiredate, interval 10 year)),substr(birthday, 6, 2), "01"), "%Y%m%d") "안식시작일",
last_day(str_to_date(concat(year(date_add(hiredate, interval 10 year)),substr(birthday, 6, 2), "01"), "%Y%m%d")) "안식종료일"
from emp;

-- lpad(month(birthday), 2, 0), '01'), '%Y%m%d') "안식시작일"
-- lpad(month(birthday), 2, 0), '01'), '%y%m%d') "안식종료일"

/*
2. score 테이블에서 학번, 국어,영어,수학, 학점, 인정여부 을 출력하기
   학점은 세과목 평균이 95이상이면 A+,90 이상 A0
                       85이상이면 B+,80 이상 B0
                       75이상이면 C+,70 이상 C0
                       65이상이면 D+,60 이상 D0
    인정여부는 평균이 60이상이면 PASS로 미만이면 FAIL로 출력한다.                   
   으로 출력한다. */

select studno, kor, eng, math, (kor + eng + math) / 3 as "평균",
case when (kor + eng + math) / 3 >= 95 then "A+"
     when (kor + eng + math) / 3 >= 90 then "A0"
     when (kor + eng + math) / 3 >= 85 then "B+"
     when (kor + eng + math) / 3 >= 80 then "B0"
     when (kor + eng + math) / 3 >= 75 then "C+"
     when (kor + eng + math) / 3 >= 70 then "C0"
     when (kor + eng + math) / 3 >= 65 then "D+"
     when (kor + eng + math) / 3 >= 60 then "D0" else "F" end as "등급",
if ((kor + eng + math) / 3 >= 60, "PASS", "FAIL") as "인정여부"
from score;


/*
3. 학생을 3개 팀으로 분류하기 위해 학번을 3으로 나누어  나머지가 0이면 'A팀', 1이면 'B팀', 2이면 'C팀'으로 
    분류하여 학생 번호, 이름, 학과 번호, 팀 이름을 출력하여라 */

select studno, name, major1,
case mod(studno, 3) when 0 then "A팀"
                     when 1 then "B팀"
                     when 2 then "C팀"
                     end as "팀"
from student;

/*
4. 학생 테이블에서 이름, 키, 키의 범위에 따라 A, B, C ,D등급을 출력하기
     160 미만 : A등급
     160 ~ 169까지 : B등급
     170 ~ 179까지 : C등급
     180이상       : D등급 */

if (deptno = 101, '컴퓨터공학', ' ') as "학과명"

select name, height,
if (height >= 180, "D",
if (height >= 170, "C",
if (height >= 160, "B",
"A"))) as "등급"
from student;

/*
5. 교수테이블에서 교수의 급여액수를 기준으로 200미만은 4급, 201~300 : 3급, 301~400:2급
    401 이상은 1급으로 표시한다. 교수의 이름, 급여, 등급을 출력하기
    단 등급의 오름차순으로 정렬하기 */

select name, salary,
if (salary >= 401, "1급",
if (salary >= 301, "2급",
if (salary >= 201, "3급",
"4급"))) as "등급"
from professor
order by "등급";

/*
6. 학생의 전공별 평균 몸무게와 학생 수를 출력하기  전공학과순으로 정렬하기 */

select major1, avg(weight), count(*) from student group by major1 order by major1;

/*
7. 사원의 직급(job)별로 평균 급여를 출력하고, 
    평균 급여가 1000이상이면 '우수', 작거나 같으면 '보통'을 출력하여라 */

select job,
if (avg(salary) <= 1000, "보통", "우수")
from emp group by job;


/*
8. 학생의 주민번호를 기준으로 남학생, 여학생의 평균키와 평균 몸무게를 출력하기 */

select if (substr(jumin, 7, 1) = 1, "남자", "여자") as "성별", avg(height), avg(weight)
from student group by substr(jumin, 7, 1);

/*
날짜의 이전, 이후 : date_add, date_sub
날짜를 문자열로 변환 : date_format (오라클 : to_char)
문자열을 날짜로 변환 : str_to_date (오라클 : to_date)
   - 형식지정문자
    %Y,%m,%d,%h,%H ...
기타 함수
   - ifnull : null인 경우 기본값으로 변환. (오라클 : nvl 함수)
   - if		: if(조건, 참, 거짓) (오라클 : dcode)
   - case when :
            case 컬럼 when 값 then 문자 ...
            else 문자 end
            
            case when 조건 then 문자 ...
            else 문자 end
그룹함수
   - 건수 : count, null 값인 경우 제외.
   - 합계 : sum
   - 평균 : avg

select 구문 완성
   - select 컬럼명 | *
   - from 테이블명 | 뷰명
   - where 조건문 => 레코드 조건. where 구문이 없는 경우 모든 레코드 선택.
   - group by 컬럼명 => 그룹함수의 그룹의 기준 컬럼
   - having 조건문 => 그룹의 조건
   - order by 컬럼
*/

-- 최대값, 최소값 : max, min
-- 학생 중 전공1별 가장 키가 큰 학생과, 작은 학생, 평균키 출력하기
select major1, max(height), min(height), avg(height) from student group by major1;

-- 교수의 급여와 보너스 합계가 가장 큰 값과, 가장 작은 값,
-- 평균 금액을 출력하기. 단, 보너스가 없으면 0으로 처리함.
select max(salary * 12 + ifnull(bonus, 0)) as "최고 금액",
       min(salary * 12 + ifnull(bonus, 0)) as "최소 금액",
		 avg(salary * 12 + ifnull(bonus, 0)) as "평균 금액" from professor;

-- 표준편차	: stddev
-- 분산			:variance
-- 학생의 국어, 영어, 수학 점수의 각각의 표준편차와 분산 출력하기
select stddev(kor) as "국어 표준편차", variance(kor) as "국어 분산",
       stddev(eng) as "영어 표준편차", variance(eng) as "영어 분산",
       stddev(math) as "수학 표준편차", variance(math) as "수학 분산" from score;

-- 문제
-- 1. 주민번호 기준 남학생, 여학생의 최대키, 최소키, 평균키 출력하기
select if(substr(jumin, 7, 1) = 1, "남학생", "여학생") as "성별", max(height), min(height), avg(height) from student group by substr(jumin, 7, 1);

-- 2. birthday 기준으로 월별 태어난 인원 수를 출력하기
select month(birthday) as "태어난 월", count(*) from student group by month(birthday);

-- 3. 전공1별 키가 가장 큰 키와 작은 키, 평균 키를 출력하기.
--    단, 평균키가 170 이상인 전공1학과만 출력하기
select major1, max(height), min(height), avg(height) from student group by major1 having avg(height) >= 170;



-- 4. 교수의 학과별 평균 급여가 300 이상인 학과의 학과코드와 평균급여,
--    인원 수 출력하기
select deptno, avg(salary), count(*) from professor group by deptno having avg(salary) >= 300;


-- 5. 교수의 직책별 교수의 인원수를 출력하기. 단, 인원수가 2명 이상인
--    직책만 출력하기
select position, count(*) from professor group by position having count(*) >= 2;

-- 6. 전화번호의 지역번호가 02 서울, 051 부산, 052 울산, 053 대구
--    055 경남 지역의 학생 수를 지역별로 출력하기.
--    단, 학생수가 3명 이상인 지역만 출력하기.
select case left(tel, instr(tel, ')') - 1) when "02" then "서울"
when "051" then "부산"
when "052" then "울산"
when "053" then "대구"
when "055" then "경남" end as "지역번호", count(*) from student
group by 1
having count(*) >= 3 and 지역번호 is not null;

-- group by 나 having 에 "" 없이 써야 컬럼명으로 인식 됨

-- 학생의 학년의 전공별 인원 수 조회하기
select grade, major1, count(*) from student group by grade, major1;

-- 순위 지정 함수 : rank over
-- 교수들의 번호, 이름, 급여, 급여순위 출력하기\
select no, name, salary, rank() over(order by salary) 급여오름차순,
       rank() over(order by salary desc) 급여내림차순
from professor
order by 5;

-- 문제
-- 1. emp 테이블에서 30번 부서 직원들의 사원번호, 이름, 급여,
-- 급여적은순위 출력하기
select empno, ename, rank() over(order by salary) "급여적은순위" from emp where deptno = 30 order by "급여적은순위";

-- 2. score 테이블에서 학생들의 학번과 총점, 총점이 많은 순위를 출력하기
select studno, kor+eng+math, rank() over(order by (kor+eng+math) desc) "순위" from score;

-- 누계 계산 함수 : sum() over()
-- 교수의 이름, 급여, 보너스, 급여 중간 합계 출력하기
select name, salary, bonus, sum(salary) over(order by salary desc) "급여 소계" from professor;

/*
join : 여러개의 테이블을 연결하여 사용하기.
*/
-- cross join : m * n 개의 레코드가 생성됨. 사용시 주의 해야 함.
select count(*) from emp -- => 14 레코드
select count(*) from dept -- => 5 레코드
-- emp 테이블과 dept 테이블 join 하기
select * from emp, dept; -- => 두 개의 테이블의 컬럼의 수 합.
                         -- 두 개의 테이블의 레코드의 수의 곱

-- 등가 조인 : Equi join
-- 조인 컬럼을 이용하여 정확한 데이터만 조회하기.
-- 조인컬럼이 같은 경우만 조회.
-- emp 테이블의 사원 이름과 부서 테이블의(dept)의 부서 이름을 조회하기

-- mariadb 방식
select ename, dname from emp, dept
where emp.deptno = dept.deptno;

-- ANSI 방식
select ename, dname from emp join dept
on emp.deptno = dept.deptno;

-- 학생테이블에서 학번, 이름, score 테이블에서 학번에 해당되는
-- 국어, 영어, 수학 점수 조회하기
select student.studno, name, kor, eng, math from student, score where student.studno = score.studno;

-- mariadb 방식
select s1.studno, name, kor, eng, math from student s1, score s2 where s1.studno = s2.studno;

-- ANSI 방식
select s1.studno, name, kor, eng, math from student s1 join score s2 on s1.studno = s2.studno;

-- 학생테이블에서 학생의 이름, 전공학과 번호(major1), 전공학과명 출력하기
-- 이름과 학과번호 학생테이블의 컬럼
-- 전공학과명 major 테이블의 컬럼
select s.name, major1, m.name from student s, major m where s.major1 = m.code;

select s.name, major1, m.name from student s join major m on s.major1 = m.code;

-- 학생 테이블과 교수 테이블을 이용하여 학생이름, 지도교수번호, 지도교수명을 출력하기
select s.name, profno, p.name from student s, professor p where s.profno = p.no;

select s.name, profno, p.name from student s join professor p on s.profno = p.no;

-- 학생의 이름, 학과명, 지도교수명 출력하기
select s.name, m.name, p.name from student s, major m, professor p where s.profno = p.no and s.major1 = m.code;

select s.name, m.name, p.name from student s join  major m on s.major1 = m.code join professor p on s.profno = p.no;
select s.name, m.name, p.name from student s join major m join professor p on s.profno = p.no and s.major1 = m.code;

-- 학생 테이블과 교수 테이블을 이용하여 2학년 학생의 학생이름, 지도교수번호, 지도교수명을 출력하기
select s.name, profno, p.name from student s, professor p where s.profno = p.no and s.grade = 2;

select s.name, profno, p.name from student s join professor p on s.profno = p.no where s.grade = 2;

-- 문제
-- 1. emp, p_grade 테이블에서 사원이름, 직급, 현재 연봉,
-- 해당 직급의 연봉 하한, 연봉 상한을 출력하기,
-- 현재 연봉은 (급여 * 12 + bonus) * 10000 으로 한다.
-- 보너스가 없으면 0으로 처리 하기
select ename, job, (salary * 12 + ifnull(bonus, 0)) * 10000 as "현재 연봉", s_pay, e_pay
from emp e join p_grade p on e.job = p.position;


-- 1. 장성태 학생의 학번, 이름, 전공1번호, 전공학과이름,학과위치(build) 출력하기
select studno, s.name, major1, m.name, build from student s join major m on s.major1 = m.code where s.name="장성태";
select studno, s.name, major1, m.name, build from student s, major m where s.major1 = m.code and s.name="장성태";

-- 2. 몸무게 80 kg 이상인 학생의 학번, 이름,체중, 학과이름, 학과위치 출력
select studno, s.name, weight, m.name, m.build from student s, major m where s.major1 = m.code and s.weight >= 80;

-- 3. 4학년 학생의 이름 학과번호, 학과이름 출력하기
select s.name, studno, m.name from student s, major m where s.major1 = m.code and s.grade = 4;

-- 4. 성이 김씨인 학생들의 이름, 학과이름 학과위치 출력하기
select s.name, m.name 학과이름, m.build 학과위치 from student s, major m where s.major1 = m.code and s.name like "김%";

-- 5. 학번과 학생이름, 소속학과이름을 학생 이름순으로 정렬하여 출력
select studno, s.name, m.name from student s, major m where s.major1 = m.code order by s.name;

-- 6. 교수별로 교수 이름과 지도 학생 수를 출력하기
select p.name, count(*) "지도 학생 수" from professor p, student s where p.no = s.profno group by p.name;

-- 7. 각 학과에 소속된 학과이름, 학생이름 ,교수이름을 출력
select m.name, s.name, p.name from major m, student s, professor p where m.code = s.major1 and m.code = p.deptno;

-- 8. 학생의 생일을 birthday를 기준으로 학생의 생일별 인원수를  다음 결과가 나오도록 sql 구문 작성하기
select count(*) 합계,
count(if(month(birthday) = 1,".",null)) "1월",
count(if(month(birthday) = 2,".",null)) "2월",
count(if(month(birthday) = 3,".",null)) "3월",
count(if(month(birthday) = 4,".",null)) "4월",
count(if(month(birthday) = 5,".",null)) "5월",
count(if(month(birthday) = 6,".",null)) "6월",
count(if(month(birthday) = 7,".",null)) "7월",
count(if(month(birthday) = 8,".",null)) "8월",
count(if(month(birthday) = 9,".",null)) "9월",
count(if(month(birthday) = 10,".",null)) "10월",
count(if(month(birthday) = 11,".",null)) "11월",
count(if(month(birthday) = 12,".",null)) "12월"
from student;