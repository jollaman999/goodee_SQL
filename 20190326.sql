/*
group 함수
 min, max : 최소/최대 값
 stddev : 표준편차
 variance : 분산

 rank() over(정렬 기준) : 순위 지정 함수. 정렬기준으로 순위 지정
 sum() over(정렬 기준) : 누계 지정 함수. 정렬기준으로 누계 지정

join
 - cross 조인 : 조인 컬럼이 없음. 두개 테이블의 레코드의 갯수 n * m
 - inner 조인 : 조인컬럼의 값이 존재하는 경우만 선택.
 - outter 조인 : 조인컬럼의 값이 존재하지 않아도 조회됨.

 - equi 조인 : 등가 조인.
               조인컬럼의 값이 같은 경우 조인의 기준으로 함.
*/

-- self 조인 : 두 개의 테이블이 동일한 테이블임.
--             ****반드시 별명을 지정해야 함.
-- 사원테이블에서 사원번호와 사원명, 상사의 이름을 출력하기
select e1.empno 사원번호, e1.ename 사원명, e2.ename 상사이름 from emp e1, emp e2
where e1.mgr = e2.empno;

-- 문제
-- 1. major 테이블에서 학과코드와 학과명 , 상위학과코드, 상위학과명 출력하기
select m1.code, m1.name, m2.code, m2.name from major m1, major m2
where m1.part = m2.code;

-- 2. 교수테이블에서 교수번호, 이름, 입사일, 자신과 입사일이 같은 사람의
--    인원 수를 출력하기. 입사일이 빠른 순으로 출력하기
select p1.no, p1.name, p1.hiredate, count(*) from professor p1, professor p2
where p1.hiredate = p2.hiredate group by p1.name order by 3;

-- 비등가 조인 : 조인 컬럼의 비교가 범위 지정하는 방식으로 조인함.
-- 고객 테이블
select * from guest;
-- 상품테이블
select * from pointitem;
-- 고객테이블과 상품테이블을 조인하여, 고객의 포인트로 받을 수 있는
-- 상품명을 출력하기
select g.name, g.point, p.name
from guest g, pointitem p
where g.point between p.spoint and p.epoint;

-- 고객테이블과 상품테이블을 조인하여, 고객의 포인트로 받을 수 있는
-- 상품명을 출력하기
-- 단, 고객이 자기 포인트보다 낮은 포인트의 상품을 선택할 수 있는 경우로 조회하기
select g.name, g.point, p.name
from guest g, pointitem p
where g.point >= p.spoint;

-- 문제
-- 1. 고객테이블과 상품테이블을 조인하여, 고객의 포인트로 받을 수 있는
-- 상품명을 출력하기. 고객이 자기포인트보다 낮은 포인트의 상품을
-- 선택할 수 있을 때, 고객의 이름, 고객 포인트, 가져갈 수 있는 상품의 갯수
-- 조회하기.
-- 단, 2개 이상의 상품을 가져갈 수 있는 고객만 조회하기.
select g.name, g.point, count(*) as 상품수
from guest g, pointitem p
where g.point >= p.spoint group by g.name having 상품수 >= 2;

-- 2. 학생의 학번, 이름, 국어, 영어, 수학, 점수합, 점수평균을 출력하기
select s.studno, s.name, sc.kor, sc.eng, sc.math,
sc.kor+sc.eng+sc.math, (sc.kor+sc.eng+sc.math)/3
from student s, score sc
where s.studno = sc.studno;

-- 3. 학생의 학번, 이름, 국어, 영어, 수학, 점수합, 점수평균, 학점을 출력하기
--    학점은 평균 기준으로 한다.
--    학점의 테이블은 scorebase 테이블에서 조회하기
select s.studno, s.name, sc.kor, sc.eng, sc.math,
sc.kor+sc.eng+sc.math, (sc.kor+sc.eng+sc.math)/3, sb.grade
from student s, score sc, scorebase sb
where s.studno = sc.studno and (sc.kor+sc.eng+sc.math)/3 between sb.min_point and sb.max_point;

-- 문제 3에서 각 학점별 인원 수 출력하기
select sb.grade, count(*)
from student s, score sc, scorebase sb
where s.studno = sc.studno and round((sc.kor+sc.eng+sc.math)/3) between sb.min_point and sb.max_point group by sb.grade;

-- 고객은 자신의 포인트 보다 작은 포인트의 상품을 수령할 수 있다고 할때
-- 무선키보드를 가질 수 있는 고객의 이름, 포인트, 상품명, 상품시작포인트,
-- 상품종료포인트 출력하기
select g.name, g.point, p.name, p.spoint, p.epoint
from guest g, pointitem p
where g.point >= p.spoint and p.name = "무선키보드";

/*
outter 조인 : inner 조인은 조건이 맞는 경우만 조회가 가능하지만,
              outer 조인은 조건이 맞지 않아도 조회가 가능하다.
     Left outer join : 왼쪽 테이블의 모든 레코드를 조회 가능함.
     right outer join : 오른쪽 테이블의 모든 레코드를 조회 가능함.
     full outer join : 양쪽 테이블의 모든 레코드를 조회 가능함.
                       union 사용을 해야함.
*/

/*
Left outer join
*/
-- 학생의 이름과 지도교수 이름 조회하기.
-- 지도교수가 없는 학생도 조회하기
select s.name, p.name from student s left join professor p
on s.profno = p.no;

-- ANSI 방식
select s.name, p.name from student s left outer join professor p
on s.profno = p.no;

-- 오라클 방식 => 여기서는 실행 안됨
select s.name, p.name from student s, professor p
on s.profno = p.no(+);

/*
right outer join
*/
-- 학생의 이름과 지도교수 이름 조회하기.
-- 지도 학생이 없는 교수도 조회하기.
select s.name, p.name from student s right join professor p
on s.profno = p.no

/*
full outer join
*/
-- 학생의 이름과 지도교수 이름 조회하기.
-- 지도 교수가 없는 학생과
-- 지도 학생이 없는 교수도 조회하기.
select s.name, p.name from student s left join professor p
on s.profno = p.no
union
select s.name, p.name from student s right join professor p
on s.profno = p.no;

-- 문제
-- 1. 학생의 이름과 지도교수 이름 조회하기.
-- 지도 교수가 없는 학생과 지도 학생이 없는 교수도 조회하기
-- 단, 지도교수가 없는 학생의 지도교수는 '0000'으로 출력하고
-- 지도 학생이 없는 교수의 지도학생은 '****'로 출력하기
select s.name 학생, ifnull(p.name, '0000') 지도교수 from student s left join professor p
on s.profno = p.no
union
select ifnull(s.name, '****'), p.name from student s right join professor p
on s.profno = p.no;

-- 2. 지도교수가 지도하는 학생의 인원 수를 출력하기.
-- 단, 지도학생이 없는 교수는 인원수 0 으로 출력하기
-- 지도교수번호, 지도교수이름, 지도학생인원수를 출력하기
select p.no, p.name, count(s.profno)
from professor p left join student s
on p.no = s.profno
group by p.no;

-- 3. emp 테이블과 p_grade 테이블을 조인하여
-- 사원의 이름, 직급, 현재연봉, 해당직급의 연봉하한, 연봉상한 출력하기
-- 단, 모든 사원이 출력되도록 하기
-- 현재연봉 : (salary * 12 + bonus) * 10000
-- 보너스가 없는 경우는 0으로 처리하기
select e.ename, e.job, (e.salary * 12 + ifnull(e.bonus, 0)) * 10000 현재연봉,
p_g.s_pay, p_g.e_pay from emp e left join p_grade p_g on e.job = p_g.position;

-- major 테이블에서 학과코드와 학과명, 상위학과코드, 상위학과명 출력하기
-- 상위학과가 없는 학과도 조회하기
select m1.code 학과코드, m1.name 학과명,
m2.code 상위학과코드, m2.name 상위학과명
from major m1 left join major m2
on m1.part = m2.code;

-- 문제
-- emp 테이블에서 사원번호, 사원명, 직급, 상사이름, 상사직급 출력하기
-- 모든 사원이 출력되어야 한다.
-- 상사가 없는 사원은 상사이름이 상사없음 출력하기
select e1.empno 사원번호, e1.ename 사원명, e1.job 직급,
ifnull(e2.ename, "상사없음") 상사이름, e2.job 상사직급
from emp e1 left join emp e2
on e1.mgr = e2.empno;

/*
subquery :
  좁은 의미 : select 내부에 where 조건절이 존재하는 select 구문
  넓은 의미 : select 내부에 존재하는 select 구문
              스칼라 : select 내부의  컬럼절이 존재하는 select 구문
              inline view : select 내부의 from 이 존재하는 select 구문

   단일행 subquery : subquery의 결과가 한개인 경우
       사용 가능 연산자 : 관계 연산자 사용가능.
   복수행 subquery : subquery의 결과가 여러개인 경우
       사용 가능 연산자 : in, any, all
*/
-- 사원 중 이혜라 사원보다 많은 급여를 받는 직원의
-- 사원번호, 사원명, 급여, 직급 출력하기
select salary from emp where ename="이혜라";
select empno, ename, salary, job from emp where salary > 600;

select empno, ename, salary, job from emp
where salary > (select salary from emp where ename="이혜라");

-- 1. 김종연 학생보다 윗학년 학생의 이름, 학년, 전공1코드, 전공학과명 출력
select s.name, s.grade, s.major1, m.name from student s, major m
where grade > (select grade from student where name="김종연") and s.major1 = m.code;

-- 2. 김종연 학생과 같은 학년의 이름, 학년, 전공1코드 전공학과명 출력
select s.name, s.grade, s.major1, m.name from student s, major m
where grade = (select grade from student where name="김종연") and s.major1 = m.code;

-- 3. 사원테이블에서 사원의 평균 급여 미만의 급여를 받는 사원의
--    사원번호, 이름, 직급, 급여 출력하기
select ename, job, salary from emp where salary < (select avg(salary) from emp);

-- 복수 행 sub query
-- 사원테이블과 부서테이블에서 근무지역이 서울인 사원의
-- 사번, 이름, 부서번호, 부서명 출력하기
select deptno from dept where loc = "서울";

select empno, ename, e.deptno, dname from emp e, dept d
where e.deptno = d.deptno
and e.deptno in (10, 20, 30, 40);

select e.empno, e.ename, e.deptno, dname from emp e, dept d
where e.deptno = d.deptno
and e.deptno in (select deptno from dept where loc = "서울");

-- 1학년 학생과 같은 키를 가지고 있는 2학년의 학생의
-- 이름, 키, 학년을 출력하기
select name, height, grade from student
where height in (select height from student where grade = 1) and grade = 2;

/*
-- 1. emp, p_grade 테이블을 조회하여 입사년(hiredate)을 기준으로 예상 직급을 조회하기
--    사원들의 이름,입사일,근속년도,현재 직급, 예상직급을 출력하기
--    근속년도는 오늘을 기준으로하고 일자를 365로 나눈 후 소숫점 이하는 버린다. 
*/
select e.ename, e.hiredate, truncate(datediff(now(), hiredate) / 365, 0), e.job, p_g.position
from emp e join p_grade p_g
where (datediff(now(), hiredate) / 365) between p_g.s_year and p_g.e_year
group by e.ename;

/*
-- 2. emp, p_grade 테이블을 조회하여 나이를 기준으로 예상직급을 조회하기
--    사원들의 이름,나이,현재 직급, 예상직급을 출력하기
--    나이는 오늘을 기준으로하고 일자를 365로 나눈 후 소숫점 이하는 버린다. 
*/
select e.ename, truncate(datediff(now(), birthday) / 365, 0), e.job, p_g.position
from emp e join p_grade p_g
where (datediff(now(), birthday) / 365) between p_g.s_age and p_g.e_age
group by e.ename;

/*
-- 3. 교수테이블에서 교수번호, 이름, 입사일과 자신보다 입사일이 빠른 
--    사람의 인원수를 출력하기. 단 입사일이 빠른 순으로 정렬하기.
*/
select p1.no, p1.name, p1.hiredate, count(p2.hiredate)
from professor p1 left join professor p2
on p1.hiredate > p2.hiredate
group by p1.name
order by p1.hiredate;

/*
-- 4. 교수 테이블에서 송승환교수보다 나중에 입사한 교수의 
--    이름, 입사일,학과명을 출력하기
*/
select p.name, p.hiredate, m.name
from professor p, major m
where p.deptno = m.code
and p.hiredate > (select hiredate from professor where name = "송승환");

/*
subquery : where 조건문에 사용되는 내부 select 구문
  단일행 subquery : 서브쿼리의 결과가 한개의 레코드인 경우
  복수행 subquery : 서브쿼리의 결과가 여러개의 레코드인 경우
                    in, any, all
                in : or 연산자 동일.
                > any : 서브쿼리 결과 중 한개 만 큰 값을 만족하는 경우
                < any : 서브쿼리 결과 중 한개 만 작은 값을 만족하는 경우
                > all : 서브쿼리 결과 중 모두 보다 큰 값을 만족하는 경우
                < all : 서브쿼리 결과 중 모두 보다 작은 값을 만족하는 경우
*/
-- 사원테이블에서 사원 직급의 최대 급여보다 급여가 많은 사람의
-- 이름, 직급, 급여 출력하기
select salary from emp where job="사원";

select e.ename, e.job, e.salary from emp e
where salary > all (select salary from emp where job="사원");

select e.ename, e.job, e.salary from emp e
where salary > (select max(salary) from emp where job="사원");

-- 사원테이블에서 사원 직급의 최소 급여보다 급여가 많은 사람의
-- 이름, 직급, 급여 출력하기
select e.ename, e.job, e.salary from emp e
where salary > any (select salary from emp where job="사원");

select e.ename, e.job, e.salary from emp e
where salary > (select min(salary) from emp where job="사원");

-- 문제
-- 1. 4학년 학생의 체중 보다 적은 학생의 이름, 몸무게, 학년 출력하기
select name, weight, grade from student
where weight < all (select weight from student where grade = 4);

-- 2. 4학년 학생들 중 키가 작은 학생보다 키가 큰 학생의 이름, 키, 학년 출력하기
select name, weight, grade from student
where weight > any (select weight from student where grade = 4);

/*
다중 컬럼 서브쿼리 : 비교 대상이 되는 컬럼이 두개 이삼
                     any, all 연산자 불가
*/
-- 학년별로 최대키를 가진 학생들의 학년과 이름, 키를 출력하기
select grade, name, height
from student
where (grade, height) in (select grade, max(height) from student group by grade)
order by grade;

select grade, max(height) from student group by grade;

-- 1학년의 최대키를 가진 학생의 학년, 이름, 키를 출력하기
select grade, name, height from student
where grade = 1 and height = (select max(height) from student where grade = 1);

-- 문제
-- 1. 학과별로 입사일이 가장 오래된 교수의 교수번호, 이름, 학과명 출력하기
select p.no, p.name, m.name from professor p, major m where p.deptno = m.code and
(deptno, hiredate) in (select deptno, min(hiredate) from professor group by deptno) order by m.name;

-- 2. 직급별로 해당 직급의 최대급여를 받는 직원의 이름, 직급, 급여 출력하기
select e.ename, e.job, e.salary from emp e where
(e.job, e.salary) in (select e.job, max(e.salary) from emp e group by job);

-- 직급별로 해당 직급의 최소급여를 받는 직원보다 적은 급여를 받는 직원의 이름, 직급, 급여 출력하기 ==> 오류 벌생
select ename, job, salary
from emp where (job, salary) < all
(select job, max(salary) from emp group by job);

/*
상호 연관 subquery : 외부 query 가 내부 query 에 영향을 주는 subquery
                     성능이 안좋다.
*/
-- 직원의 자신의 직급보다 평균급여 이상을 받는
-- 직원의 이름, 직급, 급여 출력하기
select ename, job, salary from emp e1
where salary >= (select avg(salary) from emp e2 where e2.job = e1.job);

-- 교수 자신의 직급의 평균 급여보다 적은 급여를 받는 교수의
-- 이름, 직급, 급여, 학과명 출력
select p1.name, position, salary, m.name from professor p1, major m where p1.deptno = m.code
and p1.salary < (select avg(salary) from professor p2 where p1.position = p2.position);

/*
스칼라서브쿼리 : 컬럼 부분의 subquery
*/
-- 사원의 사원번호, 이름, 부서명 출력하기
select e.empno, e.ename, d.dname from emp e, dept d
where e.deptno = d.deptno;

select empno, ename,
(select dname from dept d where d.deptno = e.deptno)
from emp e;

/*
having 절에서 사용되는 subquery
*/
-- 201 학과의 교수의 인원수 보다 큰 인원수를 가지고 있는
-- 부서의 부서코드, 부서명, 인원 수를 출력하기
select count(deptno) from professor where deptno = 201;

select deptno, m.name, count(deptno)
from professor p, major m
where p.deptno = m.code
group by deptno having count(deptno) > (select count(deptno) from professor where deptno = 201);

-- + 스칼라서브쿼리
select deptno, (select m.name from major m where p.deptno = m.code) mname, count(deptno)
from professor p
group by deptno having count(deptno) > (select count(deptno) from professor where deptno = 201);

/*
서브쿼리 사용 위치
- where 조건문
- 컬럼 부분
- having 조건문
- from 구문 => inline view
*/

-- 학년의 평균 몸무게가 70보다 큰 학년과 평균 몸무게 출력
select grade, avg(weight) from student
group by grade
having avg(weight) > 70

select * from
(select grade, avg(weight) avg from student group by grade) a
where avg > 70;

-- 문제
-- 1. 전공테이블에서 공과대학에 속학 학과 코드와 학과이름을 출력하기
select m1.code, m1.name
from major m1, major m2
where m1.part = m2.code and m2.part = 10;

select code, name from major
where part in
(select code from major where part = 10);

-- 2. 학생 중 전공1학과가 101 학과의 평균몸무게보다 몸무게가 많은 학생의
--    학번, 이름, 몸무게, 학과명 출력하기
select avg(weight) from student where major1 = 101;

select s.studno, s.name, s.weight, m.name
from student s, major m
where s.major1 = m.code
and weight > (select avg(weight) from student where major1 = 101);

/*
DDL : Data Definition Language
      데이터 정의 언어.
      객체(table, view, user, index ...)를 생성, 삭제, 수정 할 수 있는 언어
      생성 (create), 삭제 (drop), 수정 (alter) 할 수 있는 언어
      truncate 명령어 : 테이블에서 데이터를 제거하기
         => delete도 데이터를 제거함.
      
      truncate                 delete
      DDL 언어                 DML 언어
      데이터의 복구안됨
      rollback 안됨
      모든데이터가 제거   조건에 맞는 데이터 제거
      
mariadb : database => 객체들을 저장할 수 있는 저장공간.
oracle : tablespace 개념과 비슷함.
*/

-- create 명령어 => 객체를 생성할 수 있는 기능
/*
create 객체종류 객체이름 (
  컬럼이름1 자료형 제약조건
  ...
)
*/

-- test1 테이블을 생성하기.
create table test1 (
	no int primary key AUTO_INCREMENT,
	name varchar(20),
	birth datetime
)


/*
기본키 : primary key : 대표컬럼. 중복불가.
자동 증가 가능 : AUTO_INCREMENT => 오라클에는 없음.
                 기본키이면서 숫자 컬럼에만 사용가능
*/

insert into test1 (name, birth) values ("홍길동", now());
insert into test1 (name, birth) values ("홍길동", now());

desc test1;
select * from test1;

/*
기본키가 두개 컬럼인 경우
*/
create table test2 (
    num int,
    seq int,
    title varchar(100),
    content varchar(1000),
    primary key(num, seq)
)

insert into test2 (num, seq, title, content)
values (1, 1, "1-1 게시글", "1-1 내용");

insert into test2 (num, seq, title, content)
values (1, 2, "1-2 게시글", "1-2 내용");

insert into test2 (num, seq, title, content)
values (2, 1, "2-1 게시글", "2-1 내용");

insert into test2 (num, seq, title, content)
values (2, 2, "2-2 게시글", "2-2 내용");

insert into test2 (title, content)
values ("2-2 게시글", "2-2 내용");

select * from test2;

/*
태이블 생성시 기본값 설정하기
*/
drop table test3;
create table test3 (
  no int primary key,
  name varchar(20) default "홍길동"
)

insert into test3 (no) values (1);

select * from test3;

/*
기존테이블을 이용하여 테이블 생성하기
*/
-- dept 테이블과 똑같은 테이블 dept2 를 생성하기
-- 구조와 데이터도 동일하게 생성하기
select * from dept;

create table dept2
as select * from dept;
select * from dept2;

-- dept 테이블과 똑같은 테이블 dept3 를 생성하기
-- 구조는 동일하지만 데이터 저장하지 않도록 생성하기
create table dept3
as select * from dept where 1 = 2;

-- 이거도 됨. where 만 거짓이면 됨.
create table dept3
as select * from dept where 100 = 200;

select * from dept3;

-- dept 테이블과 똑같은 테이블 dept4 를 생성하기
-- 구조는 동일하지만 데이터는 서울 지역만 저장하도록 생성하기
create table dept4
as select * from dept where loc = "서울";

select * from dept;
select * from dept4;


-- dept 테이블에서 dept5 테이블 생성하기
-- dept 테이블의 deptno, dname 컬럼으로만 이루어진 테이블로 생성
create table dept5
as select deptno, dname from dept;

select * from dept5;

-- 문제
-- 1. 테이블 test4 를 생성하기
--    컬럼은 정수형인 no 가 기본키로
--    name 문자형 20자리
--    tel 문자형 20자리
--    addr 문자형 100자리로 기본값을 서울시 금천구로 설정하기
create table test4 (
  no int primary key,
  name varchar(20),
  tel varchar(20),
  addr varchar(100) default "서울시 금천구"
)

select * from test4;

-- 2. 교수 테이블로 부터 101 학과 교수들의
--    번호, 이름, 학과코드, 급여, 보너스, 직급만을 컬럼으로
--    가지는 profess_101 테이블을 생성하기
create table profess_101
as select no, name, deptno, salary, bonus, position from professor;

select * from profess_101;

-- drop : 객체 제거하기
-- drop 객체의종류 객체이름

-- test3 제거하기
drop table test3;
select * from test3;

-- test4 제거하기
drop table test4;
select * from test4;

-- tuncate 명령어
select * from dept2;
truncate table dept2;

/*
alter : 객체(table)의 구조 변경하기
*/
create table major2 as select * from major;

select * from major2;
desc major2;

-- major2 테이블에 loc 컬럼을 추가하기
alter table major2 add (loc varchar(100));

-- major2 테이블에 loc 컬럼의 크기를 50으로 변경하기
alter table major2 modify loc varchar(50);

-- major2 테이블에 loc 컬럼의 이름을 area 로 변경하기
alter table major2 change loc area varchar(50);

-- major2 테이블에 area 컬럼을 제거하기
alter table major2 drop area;

desc major2;

-- 기본 키 설정하기
select * from pointitem
-- pointitem 테이블에 no 컬럼을 기본키로 설정하기
alter table pointitem add constraint primary key(no);

-- constraint : 제약 조건
--              기본키, 외래키, ...

-- emp 테이블의 deptno 컬럼의 값은 반드시 dept 테이블의
-- deptno 컬럼의 값에 있는 값만 사용이 가능함.
-- emp 테이블의 deptno 컬럼을 외래키로 지정하기.
alter table emp add constraint foreign key(deptno)
references dept(deptno);

select * from dept;

select distinct delptno from emp;
insert into emp (empno, ename, job, salary, deptno)
values (9000, "홍길동", "임시직", 100, 50);

-- 문제
-- 1. dept2 테이블을 제거하기
drop table dept2;

-- 2. dept2 테이블을 dept 테이블의 deptno, dname의 컬럼만
-- 가지도록 하고, 데이터는 loc 값이 서울이 아닌 레코드만 
-- 선택하여 저장하기
-- dept2 테이블에 area 컬럼을 문자형 50크기로 설정하기.
-- deptno 컬럼을 dept 테이블의 deptno 컬럼의 외래키로 지정하기
create table dept2 as select deptno, dname
from dept where not loc = "서울";

alter table dept2 add(area varchar(50));

alter table dept2 add constraint foreign key (deptno)
references dept (deptno);

-- 3. student 테이블로부터 각 학년에 해당하는
-- student1 ~ student4 테이블을 각각의 데이터를 구분하여 저장하기.
create table student1 as select * from student where grade = 1;
create table student2 as select * from student where grade = 2;
create table student3 as select * from student where grade = 3;
create table student4 as select * from student where grade = 4;

-- 4. student1 ~ student4 테이블의 major1 과 major2 컬럼은
-- major 테이블의 code 컬럼을 외래키로 설정하기.
-- 또한, score 컬럼을 int 형으로 추가하기.
alter table student1 add constraint foreign key (major1) references major(code);
alter table student1 add constraint foreign key (major2) references major(code);
alter table student1 add (score int);

select * from student1;
select * from student2;
select * from student3;
select * from student4;

-- 1. 사원 테이블에서 부서별 평균연봉 중 가장 작은 평균 연봉보다 적게 받는 직원의
--  직원명,부서명, 연봉 출력하기. 
--  연봉은 급여*12+bonus. 보너스가 없는 경우는 0으로 처리한다.
select ename, d.dname, (e.salary * 12 + ifnull(bonus, 0)) 연봉
from emp e, dept d
where e.deptno = d.deptno
and (e.salary * 12 + ifnull(bonus, 0)) < all
(select avg(salary * 12 + ifnull(bonus, 0)) from emp group by deptno);


select ename, d.dname, (salary * 12 + ifnull(bonus, 0)) 연봉
from emp e, dept d
where e.deptno = d.deptno
and (salary * 12 + ifnull(bonus, 0)) <
(select min(avg) from
(select avg(salary * 12 + ifnull(bonus, 0)) avg
from emp group by deptno) a);


-- 2. 이상미 교수와 같은 입사일에 입사한 교수 중 이영택교수 보다 
--    월급을 적게받는 교수의 이름, 급여, 입사일 출력하기
select p.name, p.salary, p.hiredate
from professor p
where hiredate = (select hiredate from professor where name = "이상미")
and
p.salary < (select salary from professor where name = "이영택");

-- 3. 101번 학과 학생들의 평균 몸무게 보다  
--   몸무게가 적은 학생의 학번과,이름과, 학과번호, 몸무게를 출력하기
select studno, name, major1, weight
from student
where weight < (select avg(weight) from student where major1 = 101);

-- 4. 자신의 학과 학생들의 평균 몸무게 보다 몸무게가 적은
--   학생의 학번과,이름과, 학과번호, 몸무게를 출력하기
select studno, name, major1, weight
from student s1
where weight < (select avg(weight) from student s2 where s1.major1 = s2.major1);

-- 5. 학번이 960212학생과 학년이 같고 키는 950115학생보다  큰 학생의 이름, 학년, 키를 출력하기
select name, grade, height
from student
where grade = (select grade from student where studno = "960212")
and
height > (select height from student where studno = "950115");

-- 6. 컴퓨터정보학부에 소속된 모든 학생의 학번,이름, 학과번호, 학과명 출력하기
select studno, s.name, major1, m.name
from student s, major m
where s.major1 = m.code
and m.part = (select code from major where name = "컴퓨터정보학부");

-- 7. 학생 중에서 생년월일이 가장 빠른 학생의 학번, 이름, 생년월일을 출력하기
select studno, name, birthday from student
where birthday = (select min(birthday) from student);

-- 8. 학년별로 평균체중이 가장 적은 학년의 학년과 평균 몸무게를 출력
select grade, avg(weight) from student group by grade;

select grade, avg(weight) from student group by grade
having avg(weight) <= all (select avg(weight) from student group by grade);

select * from
     (select grade, avg(weight) avg from student group by grade) a
where avg = (select min(avg) from
             (select avg(weight) avg from student group by grade) b);

-- 9. 교수 테이블에서 평균 연봉보다 많이 받는 
--    교수들의 교수번호 이름, 연봉, 학과명을 연봉이 높은 순으로 정렬하여 출력하기. 
--    보너스가 없으면 0으로 계산함.  단 연봉은 (급여+보너스) *12 한 값이다.
select p.name, (salary + ifnull(bonus, 0)) * 12, m.name
from professor p, major m
where p.deptno = m.code
and (salary + ifnull(bonus, 0)) * 12 >
    (select avg((salary + ifnull(bonus, 0)) * 12) from professor);

/*
subquery : 상호연관 서브쿼리 => 외부쿼리의 값이 내부쿼리에 영향
스칼라 subquery : 컬럼부분에서 사용되는 서브쿼리.
having 구문에서의 subquery 가능
from 구문 subquery 가능 => inline 뷰
                        => 반드시 alias 설정이 필요함

DDL => data definition Language 데이터 정의어
       create => 객체(table, view, user, ...)를 생성 명령어
       alter => 객체의 구조를 변경하는 명령어
       drop => 객체를 제거하는 명령어
       truncate => 객체는 제거 되지 않으나 내용이 제거됨.
       commit 과 rollback 의 대상이 아님.

DML => 데이터 조작어
       C : 데이터 생성 => insert
		 R : 데이터 읽기 => select
		 U : 데이터 변경 => update
		 D : 데이터 삭제 => delete
		 commit 과 rollback 이 된다. => transaction 이다.
		 transaction => all or nothing
		 
		 insert : 데이터 추가
		   insert into 테이블명 [(컬럼명1, 컬럼명2, ... )]
		          values (값1, 값2, ... )
*/

select * from dept;
-- deptno = 90, dname = '특판팀', loc = '부산'
insert into dept (deptno, dname, loc) values (90, "특판팀", "부산");

-- deptno = 91, dname = '특판1팀', loc = '대구' 값을 가지는 레코드 추가하기
insert into dept values (91, "특판1팀", "대구");

-- deptno = 92, dname = '특판2팀' 값을 가지는 레코드 추가하기
-- 반드시 컬럼 부분이 구현되어야 함.
insert into dept (deptno, dname) values (92, "특판2팀");

-- deptno = 93, dname = '특판3팀' 값을 가지는 레코드 추가하기
insert into dept  values (93, "특판3팀", "");

/*
컬럼부분을 기술하지 않고 insert 구문 사용하기
1. 모든 컬럼을 테이블의 구조대로 값을 입력해야 함.
2. 모든 컬럼의 순서대로 값이 설정 되어야 함.
   desc 테이블명

   컬럼 부분을 기술하고 insert 구문 사용하기 => 권장
   1. 모든 컬럼에 값을 넣지 않을 때
   2. 컬럼의 순서를 모를때
   3. db의 구조 변경이 빈번 할 때
*/
desc dept;

-- 문제
-- 1. 교수테이블에 교수번호 6001, 이름 : 홍길동, id : hongkd
--    급여 : 300, 입사일 : 2019-01-01
--    직책 : 초빙교수 레코드 추가하기
insert into professor (no, name, id, position, salary, hiredate)
values (6001, "홍길동", "hongkd", "초빙교수", 300, "2019-01-01");

select * from professor where no = 6001;

-- 기존 테이블을 이용하여 데이터 추가하기
create table major3 as select * from major where 1 = 2;

-- major 테이블에서 code가 200 이상인 데이터만 major3 테이블에
-- 데이터 추가하기
insert into major3 select * from major where code >= 200;
select * from major3;

drop table major3;

-- 1. major10 테이블을 major 테이블과 같은 구조로 생성하기.
--    데이터는 추가하지 않도록 하기.
--    major10 테이블에 공과대학에 속한 학과 정보만 데이터 추가하기
drop table major10;
create table major10 as select * from major where 1 = 2;

insert into major10
select * from major
where part in (select code from major
       where part in (select code from major where name = "공과대학"));

select * from major10;

-- student1 테이블의 모든 내용을 제거하고,
-- 1학년 학생 중 평균키 이상인 학생의 정보만 저장하기
truncate student1;
select * from student1;

insert into student1
select *,0 from student
where (height >= (select avg(height) from student)) and grade = 1;

insert into student1 (studno, name, id, grade, jumin, major1)
select studno, name, id, grade, jumin, major1 from student
where (height >= (select avg(height) from student)) and grade = 1;

select * from student1;

-- 문제
select * from professor;
-- 홍길동 교수와 같은 조건으로 오늘 입사한 이몽룡 교수를 추가하기
-- 교수번호 : 6002, 이름 : 이몽룡, 입사일 : 오늘, id : monglee
delete from professor where no = 6002;

insert into professor (no, name, id, position, salary, hiredate)
select 6002, "이몽룡", "monglee", position, salary, current_date()
from professor
where name = "홍길동";

select * from professor;

/*
update : 컬럼의 값을 수정하기

update 테이블명 set 컬럼1=값1, 컬럼2=값2, ...
[where 조건문] => 없으면 모든 레코드가 수정.
               => 있으면 조건문의 결과가 참인 경우만 수정.
*/
-- 사원 중 직급이 사원인 경우 보너스를 10만원 인상하기
-- 보너스가 없는 경우 0으로 처리함.
select ename, job, bonus, ifnull(bonus, 0) + 10 예상보너스
from emp where job = "사원";

-- => 수정하기
update emp set bonus = ifnull(bonus, 0) + 10
where job = "사원";

-- 이상미 교수 와 같은 직급의 교수 중 급여가 350 미만인 교수의 급여를
-- 10% 인상하기
select * from professor
where position = (select position from professor where name = "이상미")
and salary < 350;

/* 원래 값*/
update professor set salary = 300
where name = "조황섭";

update professor set salary = salary * 1.1
where position = (select position from professor where name = "이상미");

-- rollback
set autocommit = 0;
update professor set salary = 300 where name = "조황섭";
select * from professor where name = "조황섭";
rollback;

-- 문제
-- 변경전 조회. 수정, 변경 후 조회
-- 1. 보너스가 없는 시간 강사의 보너스를 조교수의 평균보너스의 50%
--    변경하기
update professor set bonus = (select avg(bonus) from professor where name like "조%") * 0.5
where bonus is null and position = "시간강사";

-- 2. 지도교수가 없는 학생의 지도교수를 이용학생의 지도교수로 변경하기
update student set profno = (select profno from student where name = "이용")
where profno is null;

-- 3. 교수 중 홍길동과 같은 직급의 교수의 급여를 101 학과의
--    평균 급여로 변경하기. 단 소숫점 이하는 반올림하기.
update professor set salary = (select round(avg(salary)) from professor where deptno = 101)
where position = (select position from professor where name = "홍길동");

/*
delete : 레코드를 삭제
delete from 테이블명
[where 조건문] => 없으면 모든 레코드 삭제
               있으면 조건문의 결과가 참인 경우만 삭제
*/

select * from dept;

-- dept 테이블에서 90번 이상의 부서를 삭제하기
delete from dept where deptno >= 90;

set autocommit = 0; -- 수동 commit 으로 설정하기

commit; -- => transaction 의 종료

rollback;

/*
transaction => all or nothing
시작과 끝 => commit 부터 다음 commit 까지
rollback은 모든 거래를 취소
   insert, update, delete
DDL : DDL 문장이 실행 되면 자동 commit 됨.
*/
select * from dept;
insert into dept values (90, "특판팀", "");
drop table test1;
rollback;
select * from test1;

/*
SQL 종류

DDL : Data Definition Language (데이터 정의어)
      create, alter, drop, truncate
DML : Data Manupulation Language (데이터 조작어)
      select, insert, update, delete
TCL : Transaction Control Language (트랜젝션 제어어)
      commit, rollback
DCL : Data Control Language (데이터 제어어)
      grant : 권한 주기
		revoke : 권한 뺏기
*/

/*
View : 가상 테이블
       물리적으로 메모리 할당이 없음.
       테이블처럼 사용됨. => 제약은 있음
*/
select * from student where grade = 2;

-- 2학년 학생의 학번, 이름, id, height, weight 뷰를 생성하기
create or replace view v_stu2
as select studno, name, id, height, weight from student
where grade = 2;

select * from v_stu2;

-- 2학년 학생 중 유진성 학생의 키가 172로 수정하기.
update student set height = 172 where name = "유진성" and grade = 2;

-- 문제 2학년 학생의 학생이름, 지도교수번호, 지도교수이름을
-- 가지는 view v_stu_prof 생성하기
create or replace view v_stu_prof
as select s.name 학생이름, profno, p.name 지도교수이름
from student s, professor p
where s.profno = p.no and s.grade = 2;

select * from v_stu_prof;

-- 3학년 학생으로 이루어진 v_stu3 뷰 생성하기
create or replace view v_stu3
as select * from student where grade = 3;

select * from v_stu3;

-- 3 학년 학생의 학번, 이름, 학과명 출력하기
select v.studno, v.name, m.name
from v_stu3 v, major m
where v.major1 = m.code;

-- view 에 insert 가 된다.
insert into v_stu3 (studno, name, id, grade, jumin)
values (5001, "홍길동", "hongkd2", 3, "9001011023456");

select * from student where grade = 3;

delete from v_stu3 where studno = 5001;

/*
View : 원래테이블의 내용을 가상의 테이블로 생성.
       view 의 CRUD 실행하면, 원래테이블로부터 실행된다.
       => 모든 뷰가 가능한 것은 아니다.
       단순뷰 : 한개의 테이블로 이루어진 뷰
                 CRD 가 가능하다.
       복합뷰 : (여러개의 테이블로 이루어진 뷰)
                CUD 가 안될 수 있다.
*/

-- 1. 교수 테이블에서 홍길동교수와 같은 직급의 교수를 퇴직시키기
delete from professor
where position = (select position from professor where name = "홍길동");

-- 2. 교수 테이블에서 교수번호,이름, 이메일, url 컬럼만을 가지는 v_prof
--        view 를 생성하기.
create or replace view v_prof
as select no, name, email, url
from professor;

select * from v_prof;

-- 3. 학생테이블 중 1학년 학생의 키정보를 저장하는 v_height1 뷰를 생성하기. 
--    단, 컬럼은 학번, 학년, 키 로 구성된다.
create or replace view v_height1
as select studno, grade, height
from student where grade = 1;

select * from v_height1;

--4. 학생테이블 중 1학년 학생의 몸무게정보를 저장하는 v_weight1 뷰를 생성하기. 
--   단, 컬럼은 학번, 학년, 몸무게 으로 구성된다.
create or replace view v_weight1
as select studno, grade, weight
from student where grade = 1;

select * from v_weight1;

-- 5. 학생의 전공별 최대키,최대몸무게를 저장하는 v_stu_max 뷰를 생성하기
create or replace view v_stu_max
as select major1, max(height), max(weight)
from student
group by major1;

select * from v_stu_max;

/*
inline 뷰 : 이름이 없고, 일회성 사용되는 뷰
            select 구문에 from 절에 사용되는 subquery를 말한다.
            반드시 별명을 설정해야 한다.
*/
-- 학생의 학번, 이름, 학년, 키, 몸무게, 학년의 최대키, 최대몸무게 출력
select studno, name, grade, height, weight,
       (select max(height) from student s2 where s2.grade = s1.grade),
       (select max(weight) from student s2 where s2.grade = s1.grade)
from student s1;

-- inline view
select studno, name, s.grade, height, weight, max_h, max_w
from student s,
    (select grade, max(height) max_h, max(weight) max_w
     from student group by grade) a
where s.grade = a.grade;

-- 교수번호, 이름, 부서코드, 부서명, 자기부서의 평균급여,
-- 자기부서의 평균보너스 출력하기.
-- 단, 보너스가 없으면 0으로 처리하기
select p.no, p.name, p.deptno, m.name, a.avg_salary, a.avg_bonus
from professor p, major m,
(select deptno, avg(salary) avg_salary, avg(ifnull(bonus, 0)) avg_bonus from professor group by deptno) a
where p.deptno = m.code and p.deptno = a.deptno;