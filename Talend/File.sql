

CREATE DATABASE `webscrapedb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;


-- webscrapedb.t_pythonobjects definition

CREATE TABLE `t_pythonobjects` (
  `pythonobj` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- webscrapedb.t_redditapi definition

CREATE TABLE `t_redditapi` (
  `comment` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


with p as (
select tr.comment, 
		count(*) as countp
from webscrapedb.t_redditapi tr 
where tr.comment in (
select  distinct(tr.comment) from 
webscrapedb.t_redditapi tr 
inner join webscrapedb.t_pythonobjects tp
on trim(tr.comment) like CONCAT('%', trim(tp.pythonobj)  , '%'))
group by tr.comment )
