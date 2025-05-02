CREATE TABLE board5(
      no NUMBER PRIMARY KEY,         -- 원글 번호
      refno NUMBER,               -- 상위 번호
      subject varchar2(100),         -- 제목    
      wrlter number,               -- 작성자(사원번호)
      content varchar2(500),         -- 내용   
      readcnt NUMBER,               -- 조회수
      regdte DATE,               -- 등록일
      uptdte DATE                  -- 수정일
);
create sequence board5_seq;
SELECT board5_seq.nextval FROM dual;
-- no refno subject wrlter content readcnt regdte uptdte
SELECT * FROM board5;

INSERT INTO board5 values(1,0,'제목',7639,'안녕하세요',0,sysdate ,sysdate);

DROP TABLE board_cafe_comment;

CREATE TABLE board_cafe_comment(      -- 댓글을 저장할 테이블
   num NUMBER PRIMARY KEY,            -- 댓글의 글번호
   writer number,            -- 댓글 작성자의 아이디
   content varchar2(500),            -- 댓글 내용
   no NUMBER ,                     -- 원글의 글번호 
   trgdate DATE                           
   );

SELECT * FROM board_cafe_comment;
create sequence board5_seq;
SELECT board5_seq.nextval FROM dual;
INSERT INTO BOARD_CAFE_COMMENT VALUES( 1, 7369, '댓글',1 ,sysdate);





