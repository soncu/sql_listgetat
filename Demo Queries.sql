/*
	Try these queries to see the actual results
*/
SELECT dbo.MyListGetAt('-one-two-three-four-five', 3, '-', 1)-- 'three'
SELECT dbo.MyListGetAt('-one-two-three-four-five', -2, '-', 1)-- 'four'
SELECT dbo.MyListGetAt('-one-two-three-four-five', -6, '-', 0)-- ''
SELECT dbo.MyListGetAt('1,2,,,4,5', 3, default, default)-- 4
SELECT dbo.MyListGetAt('1,2,,,4,5', 4, default, 0)-- 1,2,,*,4,5
SELECT dbo.MyListGetAt('1,2,,,4,5', -5, default, 0)-- 2
SELECT dbo.MyListGetAt(';This is,- just; a-, test; case-', 4, default, 0)-- ' test; case-'
SELECT dbo.MyListGetAt(';This is,- just; a-, test; case-', 4, ';,-', 0)-- ' just'
SELECT dbo.MyListGetAt(';This is,- just; a-, test; case-', -5, ';,-', 0)-- ' a'
SELECT dbo.MyListGetAt(';This is,- just; a-, test; case-', -5, ';,-', default)-- 'This is'
SELECT dbo.MyListGetAt(';This is,- just; a-, test; case-', -5, ';,- ', 1)-- 'is'
