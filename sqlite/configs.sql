/* These first two lines format the SELECT statement output to be more readable. */
/* To see the full list of these SQLite-specific commands, type '.help'.         */
/*.mode html*/
.mode column
.headers on
.nullvalue NULL
.width 25 25 25 25 25
/*.output output.html*/

/*Some basic testing */
drop table if exists T;
create table T (ColA text, ColB text);
insert into T values ('Hello,', 'world from SQLite!');
insert into T values ('If you see it,', 'it means everything works!');
select * from T;

