#1.Grass타입의 포켓몬의 이름을 사전순으로 출력
SELECT name
FROM pokemon
WHERE type = 'Grass'
ORDER BY name;
#사전순으로 출력하므로 ORDER BY 이용

#2.Brown City나 Rainbow City출신 트레이너의 이름을 사전순으로 출력
SELECT name
FROM trainer
WHERE hometown = 'Brown City' or hometown = 'Rainbow City'
ORDER BY name;
#두가지 city에 사는 사람들로 조건을 걸기 위해 where에서 or사용

#3.모든 포켓몬의 type을 중복없이 사전순으로 출력
SELECT distinct type
FROM pokemon
ORDER BY type;
#중복을 없애기 위해 distinct사용

#4.도시의 이름이 B로 시작하는 모든 도시의 이름을 사전순으로 출력
SELECT name
FROM city
WHERE name like 'B%'
ORDER BY name;
#string과 관련된 조건을 걸기 위해 사용 가능한 것 % 또는 _ 인데 이 경우 B로 시작하는 모든 도시니까 % 사용


#5.이름이 M으로 시작하지 않는 트레이너의 고향을 사전순으로 출력
#고향을 출력하니까 select 고형-- 
SELECT hometown
FROM trainer
WHERE name not like 'M%'
ORDER BY hometown;
#M으로 시작하지 않는 이므로 not like로 조건을 만족시키게 한다

#6.잡힌 포켓몬 중 가장 레벨이 높은 포켓몬의 별명을 사전순으로 출력
SELECT nickname
FROM catchedpokemon
WHERE level = (SELECT MAX(level)
			   FROM catchedpokemon
               LIMIT 1)
ORDER BY nickname;
# where에서 level = 하고 들어가는 서브쿼리는 잡힌 포켓몬에서 가장 높은 레벨을 출력해준다.
# 그 출력된 레벨과 같으면 max레벨이므로 그 닉네임을 사전순으로 출력해주면 된다

#7.포켓몬의 이름이 알파벳 모음으로 시작하는 포켓몬의 이름을 사전순으로 출력
SELECT name
FROM pokemon
WHERE name like 'a%' or name like 'e%' or 
	  name like 'o%' or name like 'u%' or name like 'i%'
ORDER BY name;
#이름이 모음으로 시작하는 포켓몬이므로 aeiou각 경우에 대해 or로 조건을 걸어준다

#8.잡힌 포켓몬의 평균 레벨을 출력
SELECT AVG(level)
FROM catchedpokemon;
#잡힌 포켓몬의 평균 레벨은 AVG한수를 사용해서 구해준다

#9.Yellow가 잡은 포켓몬의 최대 레벨을 출력
SELECT MAX(level)
FROM catchedpokemon
WHERE id = (SELECT id
	        FROM trainer
            WHERE name = 'Yellow');

# where에 들어간 서브 쿼리는 yellow의 id를 출력해준다 그 id로
# 잡은 포켓몬의 최대 레벨은 MAX로 구해준다
            
#10.트레이너의 고향 이름을 중복없이 사전순으로 출력
SELECT distinct hometown
FROM trainer
ORDER BY hometown;
#중복이 없어야 하므로 distinct를 사용한다


#11.닉네임이 A로 시작하는 포켓몬을 잡은 트레이너의 이름과 포켓몬의 닉네임을
#트레이너의 이름의 사전순으로 출력

SELECT name, nickname
FROM catchedpokemon, trainer
WHERE nickname like 'A%' and trainer.id = owner_id
ORDER BY name;

#여기서 id = owner_id 하면 안됨 id가 catchedpokemon에도 있어서
#trainer꺼랑 비교하라고 앞에 명시 해줘야됨 
# from에 두개 table 있으면 cartesian product 해서 출력하므로
# where에서 trainer.id = owner_id 로 의미 있는 조합의 튜플만 살려낸다


#12.Amazon 특성을 가진 도시의 리더의 트레이너 이름을 출력
SELECT name
FROM trainer
WHERE id = (SELECT leader_id
			FROM gym
			WHERE gym.city = (SELECT name
							  FROM city
							  WHERE description = 'Amazon'));
# 제일 안쪽의 sub 쿼리는 아마존 특성의 도시 이름을 출력해준다
# 그 다음의 쿼리는 그 도시 이름과 같은 gym의 리더 id를 출력해준다
# 그 리더 id와 같은 것을 trainer 에서 골라주면 원하는 답이 나오게 된다

#13.불속성 포켓몬을 가장 많이 잡은 트레이너의 id와, 
#그 트레이너가 잡은 불속성 포켓몬의 수를 출력

#조인 3개도 가능 여러개 해보자

SELECT trainer.name, count(nickname)
FROM catchedpokemon
JOIN pokemon ON pid = pokemon.id
JOIN trainer ON trainer.id = owner_id
where type = 'fire'
group by trainer.id
order by count(nickname) DESC
LIMIT 1;

# catchedpokemon 과 pokemon, trainer이 세개의 테이블이 join으로
# 의미 있게 연결되게 된다. 그 이후 type 이 fire인 튜플들만 살리고
# trainer로 group을 지어준다 id나 이름등을 활용하여...
# 그 후 fire 포켓몬의 닉네임 수를 세서 내림차순으로 한후 limit 1로 한 튜플만
# 출력해주면 원하는 결과를 구할 수 있다


# 14. 포켓몬 ID가 한 자리 수인 포켓몬의 type을 
#중복 없이 포켓몬 ID의 내림차순으로 출력하세요

SELECT distinct type
FROM pokemon
WHERE 1<= id and id <= 9
ORDER BY id DESC;

#포켓몬 수가 한자리 라는 것은 수학적으로 1<= id <= 9를 의미하고 이를 조건으로 넣어준다



#15.포켓몬의 type이 Fire이 아닌 포켓몬의 수를 출력
SELECT count(name)
FROM pokemon
WHERE type != 'fire';

# 'fire'이 아닌 것이므로 !=로 where에 조건을 넣어준다

#16.진화하면 id가 작아지는 포켓몬의 진화 전 이름을 사전순으로 출력

SELECT name
FROM evolution
JOIN pokemon ON before_id = id
WHERE before_id > after_id
ORDER BY name;

#이렇게 join 하면 조건 만족하는 tuple만 함쳐져서 나타남
#진화하면 id가 작아져야 하므로 before_id > after_id 이 조건으로 원하는
#내용을 얻어준다

#17.트레이너에게 잡힌 모든 물속성 포켓몬의 평균 레벨을 출력

SELECT AVG(level)
FROM catchedpokemon
JOIN pokemon ON pid = pokemon.id
WHERE type = 'fire';


#18. 체육관 리더가 잡은 모든 포켓몬 중 레벨이 가장 높은 포켓몬의 
#별명을 출력하세요

SELECT nickname
FROM catchedpokemon
JOIN gym ON leader_id = owner_id
WHERE level = (SELECT MAX(level)
			   FROM catchedpokemon
			   JOIN gym ON leader_id = owner_id);

#서브 쿼리문은 잡힌 포켓몬에서 체육관 리더가 잡은 포켓몬에 한해서 최대 레벨을 출력한다
#이와 같은 레벨을 갖는 포켓몬의 닉네임을 출력해주면 되므로 이중 쿼리로 해결한다

#19. Blue city 출신 트레이너들 중 잡은 포켓몬들의 레벨의 
#평균이 가장 높은 트레이너의 이름을 사전순으로 출력하세요

SELECT name
FROM catchedpokemon
JOIN trainer ON trainer.id = owner_id
WHERE hometown = 'Blue City'
GROUP BY name
ORDER BY AVG(level) DESC, name ASC
LIMIT 1;

# GROUP BY 까지 blu city 출신 trainer들의 이름을 기준으로 그루핑 해주고
# 평균 레벨로 내림차순, 이름으로 오름차순 하여, limit 1 으로 레벨 평균이 가장 높은 한명을 출력한다



#SELECT *
#FROM city, gym;
#그냥 이런식으로 작성하면 두 table이 cartesian product 곱집합 되서
#다 나옴

#SELECT name, city
#FROM city, gym
#이런 식으로 하면 cartesian product 한거에서 저 컬럼만 나옴

#20. 같은 출신이 없는 트레이너들이 잡은 포켓몬중 진화가 가능하고 
#Electric 속성을 가진 포켓몬의 이름을 출력하세요

SELECT name
FROM catchedpokemon
JOIN pokemon ON pokemon.id = pid
WHERE owner_id in (SELECT id
					FROM trainer
					GROUP BY hometown
					HAVING COUNT(hometown) = 1)
				
                AND pid in (SELECT before_id
							FROM evolution)
				AND type = 'Electric';
                
# 같은 출신이 없다는 것은 hometown으로 그루핑 하여 count(hometown)을 해보았을 때
# 그 수가 1임을 의미하므로 이를 서브쿼리로 조건을 넣어준다
# 그 후 진화가 가능해야 하므로 pid가 evolution table의 before에 있어야 하고 type 도 electric으로 조건을 걸어준다



# 21. 관장들의 이름과 각 관장들이 잡은 포켓몬들의 레벨 합을 레벨 합의 
# 내림차 순으로 출력하세요

SELECT name, SUM(level)
FROM gym, trainer, catchedpokemon
WHERE leader_id = trainer.id and leader_id = owner_id
GROUP BY leader_id
ORDER BY SUM(level) DESC;

# 각 관장들이 잡은 포켓몬에 대해 논하므로 gym과 trainer catchedpokemon 을 cartesian product후
# 조건을 통해 원하는 튜플만 솎아낸다 그 후 group by 와 order by 로 맞춰준다


# 22. 가장 트레이너가 많은 고향의 이름을 출력하세요.

SELECT hometown
FROM trainer
GROUP BY hometown
ORDER BY COUNT(hometown) DESC
LIMIT 1;

# 가장 트레이너가 많다는 건 count(hometown)을 descending order로 정렬했을 때 가장 위에 있는 것이다

#23. Sangnok City 출신 트레이너와 Brown City 출신 트레이너가 
#공통으로 잡은 포켓몬의 이름을 중복을 제거하여 사전순으로 출력하세요

SELECT distinct pokemon.name
FROM catchedpokemon
JOIN trainer ON trainer.id = owner_id
JOIN pokemon ON pid = pokemon.id
WHERE hometown = 'Sangnok City'
AND pid in (SELECT pid
			FROM catchedpokemon
			JOIN trainer ON trainer.id = owner_id
			WHERE hometown = 'Brown City')
ORDER BY pokemon.name;

#SELECT *
#FROM catchedpokemon
#JOIN trainer ON trainer.id = owner_id
#JOIN pokemon ON pid = pokemon.id
#WHERE hometown = 'Brown City';
#여기 까지 하면 브라운 도시 출신 트레이너가 잡은 포켓몬들에 대한 내용이 된다

#SELECT *
#FROM catchedpokemon
#JOIN trainer ON trainer.id = owner_id
#JOIN pokemon ON pid = pokemon.id
#WHERE hometown = 'Sangnok City';
#반면 이렇게 하면 상록시티 출신 트레이너가 잡은 포켓몬들과 관련된 내용이 되므로
# 서브쿼리로 문제를 해결한다

#24. 이름이 P로 시작하는 포켓몬을 잡은 트레이너 중 
#상록 시티 출신인 트레이너의 이름을 사전순으로 모두 출력하세요

SELECT trainer.name
FROM trainer
JOIN catchedpokemon ON trainer.id = owner_id
JOIN pokemon ON pokemon.id = pid
WHERE pokemon.name like 'P%' 
and hometown = 'Sangnok City'
ORDER BY trainer.name;

# where에서 먼저 앞 조건은 P로 시작하는 포켓몬 이고 뒤 조건은 상록시티 출신인 사람이 된다

#25. 트레이너의 이름과 그 트레이너가 잡은 포켓몬의 이름을 출력하세요. 
#이때 트레이너 이름은 사전 순으로 정렬하고, 
#각 트레이너가 잡은 포켓몬도 사전 순으로 정렬하세요.

SELECT trainer.name, pokemon.name
FROM trainer
JOIN catchedpokemon ON trainer.id = owner_id
JOIN pokemon ON pokemon.id = pid
ORDER BY trainer.name ASC, pokemon.name ASC; 
#roder by 에서 각 조건에 대해 어떤 순으로 출력할지 정해주면 된다

#26. 2단계 진화만 가능한 포켓몬의 이름을 사전순으로 출력하세요

select pokemon.name
from pokemon, evolution #from에 이렇게 적으면 cartesian product함
WHERE pokemon.id = before_id
AND after_id not in (select before_id
					 from evolution)
AND before_id not in (select after_id
					  from evolution)
ORDER BY name;

# 2단계 진화만 가능해야 하니까 after_id 가 before에 없고
# befor id가 after에 없어야 한다

#27. 상록 시티의 관장이 잡은 포켓몬들 중 포켓몬의 타입이 WATER 인 포켓몬의 별명을
#사전순으로 출력 하세요

SELECT nickname
FROM catchedpokemon
JOIN gym ON owner_id = leader_id
JOIN pokemon ON pid = pokemon.id
WHERE city = 'Sangnok City'
AND type = 'Water'
ORDER BY nickname;

# where에 원하는 조건 두개를 and로 걸어줌으로써 해결한다

#28. 트레이너들이 잡은 포켓몬 중 진화한 포켓몬이 3마리 이상인 경우 해당 트레이너의
#이름을 사전순으로 출력하세요

SELECT trainer.name
FROM trainer
JOIN catchedpokemon ON owner_id = trainer.id
WHERE pid in (SELECT after_id
			  FROM evolution)
GROUP BY trainer.id
HAVING COUNT(trainer.id) >= 3
ORDER BY trainer.name;

# 진화한 포켓몬이 세마리 이상이여야 하므로 일단 진화한 포켓몬 에 대해서만 얻기 위해
# where을 위와 같이 작성해준다. 그 후 그루핑 후 count로 세마리 이상인 경우를 뽑아낸다


#29. 어느 트레이너에게도 잡히지 않은 포켓몬의 이름을 사전 순으로 출력하세요

SELECT name
FROM pokemon
WHERE id NOT IN (SELECT pid
				  FROM catchedpokemon)
ORDER BY name;

#어느 trainer 에게도 잡히지 않았다는 것은 catchedpokemon 에 pokemon의 id가
#없다는 것을 의미하므로 위와 같이 해결해준다


#30. 각 출신 도시별로 트레이너가 잡은 포켓몬중 가장 레벨이 
#높은 포켓몬의 레벨을 내림차순으로 출력 하세요.
 
SELECT MAX(level)
FROM trainer
JOIN catchedpokemon ON owner_id = trainer.id
GROUP BY hometown
ORDER BY MAX(level) DESC;

#출신 도시별로 트레이너들이 잡은 포켓몬이므로 hometown 으로 그루핑하고
#최대 레벨을 기준으로 내림차순 정렬한다

#31. 포켓몬 중 3단 진화가 가능한 포켓몬의 ID 와 해당 포켓몬의
#이름을 1단진화 형태 포켓몬의이름, 2단진화 형태 포켓몬의 이름, 
#3단 진화 형태 포켓몬의 이름을 ID 의 오름차순으로 출력하세요

#self join 사용
select p1.id ,p1.name, p2.name, p3.name
FROM evolution e1
JOIN evolution e2 ON e1.after_id = e2.before_id 
JOIN pokemon p1 ON p1.id = e1.before_id
JOIN pokemon p2 ON p2.id = e2.before_id
JOIN pokemon p3 ON p3.id = e2.after_id
ORDER BY p1.id;

#self조인으로 해결할 수 있다. 우선 evoultion 에서 e1과 e2를 가져온다
#e2의 before 는 e1의 after와 연결 되므로 e1.before 이 1단계 e1.after = e2.before이 2단계 e2.after 이 3단계가 된다
# 그 후 각 e1.before, e2.before, e2.after 1, 2, 3단계에 맞게 pokemon을 join하고 출력한다

