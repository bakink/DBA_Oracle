column sid format 9999 heading "Blocked|SID"
column event format a35 heading "Wait event"
column object format a40 heading "Object Type: name"
column sql_text format a70 heading "SQL Text" 
column blocking_session format 999 heading "Blocking|SID"
column time_ms format 999,999.99 heading "MS|Waited"


SELECT sid, event, wait_time_micro / 1000 time_ms, blocking_session,
       object_type || ': ' || object_name object, sql_text 
  FROM v$session s 
  LEFT OUTER JOIN v$sql
       USING (sql_id)
  LEFT OUTER JOIN dba_objects
       ON (object_id = row_wait_obj#)
WHERE event LIKE 'enq: %';

column sid clear
column event clear
column object clear
column sql_text clear
column blocking_session clear
column time_ms clear
