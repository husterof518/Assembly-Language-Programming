.386
DATAS SEGMENT USE16

BUF  DB "********************************************************************************"
     DB "                           STUDENT MANAGEMENT SYSTEM                            " 
     DB "            ******************************************************              "
     DB "                    *INPUT  A || F || S || E  FOR  CHOICE",0AH,0DH
     DB "            ******************************************************              "
     DB "                    *       A FOR ADD NEW SUBJECT          *                    "
     DB "                    *   F FOR FIND SOME STUDENT'S GRADE    *                    "
     DB "                    *   WHEN YOU FIND B FOR EXIT FIND      *                    "
     DB "                    *   S FOR SHOW ALL  STUDENTS' GRADE    *                    "
     DB "                    *       E   FOR  EXIT  SYSTEM          *                    "
     DB "********************************************************************************",'$'
SUBJECT DB "STID    CLGE    ASSL    OOPL    MATH    ENGL                    SUM    RANK",0DH,0AH,'$'
MAINSHOW DB "INPUT YOUR CHOICE>>>  ",'$'
ENTERSHOW DB 0AH,0DH,'$'
CHOICESHOW DB 3
           DB 0
           DB 3 DUP(0),0AH,0DH,'$'    
BUF1  DB " 01      30      70      60      40      90                      ",0,0,"     0",0DH,0AH,'$'  
SUM=$-BUF1
BUF2  DB " 02      58      68      58      67      83                      ",0,0,"     0",0DH,0AH,'$'    
BUF3  DB " 03      75      99      75      93      86                      ",0,0,"     0",0DH,0AH,'$'    
BUF4  DB " 04      55      98      87      92      84                      ",0,0,"     0",0DH,0AH,'$'    
BUF5  DB " 05      89      59      85      85      76                      ",0,0,"     0",0DH,0AH,'$'    
BUF6  DB " 06      70      69      76      93      73                      ",0,0,"     0",0DH,0AH,'$'    
BUF7  DB " 07      56      80      89      90      81                      ",0,0,"     0",0DH,0AH,'$'    
BUF8  DB " 08      89      88      65      70      73                      ",0,0,"     0",0DH,0AH,'$'    
BUF9  DB " 09      67      69      87      80      90                      ",0,0,"     0",0DH,0AH,'$'    
BUF10 DB " 10      78      92      83      71      65                      ",0,0,"     0",0DH,0AH,'$'    
BUF11 DB " 11      94      77      83      72      77                      ",0,0,"     0",0DH,0AH,'$' 
BUF12 DB " 12      93      76      65      69      89                      ",0,0,"     0",0DH,0AH,'$' 
BUF13 DB " 13      97      75      95      68      86                      ",0,0,"     0",0DH,0AH,'$' 
BUF14 DB " 14      78      83      85      75      64                      ",0,0,"     0",0DH,0AH,'$' 
BUF15 DB " 15      90      84      95      85      87                      ",0,0,"     0",0DH,0AH,'$' 
BUF16 DB " 16      68      85      76      84      66                      ",0,0,"     0",0DH,0AH,'$' 
BUF17 DB " 17      90      89      83      89      59                      ",0,0,"     0",0DH,0AH,'$' 
BUF18 DB " 18      89      98      82      86      90                      ",0,0,"     0",0DH,0AH,'$' 
BUF19 DB " 19      86      84      78      86      66                      ",0,0,"     0",0DH,0AH,'$' 
BUF20 DB " 20      85      73      90      86      84                      ",0,0,"     0",0DH,0AH,'$' 
BUF21 DB " 21      93      84      93      69      83                      ",0,0,"     0",0DH,0AH,'$' 
BUF22 DB " 22      82      90      90      68      94                      ",0,0,"     0",0DH,0AH,'$' 
BUF23 DB " 23      81      60      78      78      67                      ",0,0,"     0",0DH,0AH,'$' 
BUF24 DB " 24      84      75      77      55      80                      ",0,0,"     0",0DH,0AH,'$' 
BUF25 DB " 25      82      68      76      67      88                      ",0,0,"     0",0DH,0AH,'$' 
BUF26 DB " 26      90      59      69      93      79                      ",0,0,"     0",0DH,0AH,'$' 

INPUTID DB "PLEASE INPUT STUDENTID:",'$'
ID  DB 4
    DB 0
    DB 4 DUP(0),0AH,0DH,'$'
    
NOTEXIST DB "THIS STUDENT DOESN'T EXIST.PLEASE INPUT BETWEEN 01 ~~ 26."
         DB "AND B FOR BACK TO MAIN",0DH,0AH,'$'
INVALIDSHOW DB "INVALID OPERATION.PLEASE CHOOSE A OR F OR S OR E",0DH,0AH,'$'
RESULT DW 28 DUP(0)
NEWSUBJECT DB "PLEASE INPUT NEW SUBJECT'S NAME:",'$'
SUBJECTNAME  DB 8
             DB 0
             DB 8 DUP(0)
ADDTIP DB "PLEASE INPUT THE STUDENT'S SCORE FROM 01 TO 26.THE SCORE MUST FROM 00 TO 99.",0AH,0DH,'$'
STUDENT DB "STUDENT",'$'
STUDENTID DB "01:02:03:04:05:06:07:08:09:10:11:12:13:14:15:16:17:18:19:20:21:22:23:24:25:26:",'$'
SCORES    DB 6
          DB 0
          DB 6 DUP(0)
COUNT DW 5,'$'
DATAS ENDS

STACKS SEGMENT USE16
     DB 200 DUP(0);�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT  USE16
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV  AX,DATAS
    MOV  DS,Ax
    
CHANGESTN MACRO BUFS,RES      
    MOV  AH,BUFS                    ;�궨�彫BUFS����Ӧ���ֽڱ���������ַ�
    SUB  AH,30H                     ;ת��Ϊʮ�������������ν�����������RES
    MOV  AL,BUFS+1                  ;�ֽڱ�������Ӧ���ֵ�Ԫ��
    SUB  AL,30H
    XOR  DX,DX
    MOV  DL,AH
    IMUL DX,10
    MOV  AH,0
    ADD  DX,AX
    ADD  RES,DX
    ENDM    
    
CHANGENTS MACRO BUFS,RES            ;�궨�彫��BUFSΪƫ�Ƶ�ַ�������ֽڵ�Ԫ
    XOR  AX,AX                      ;��ʾ��ʮ������ת��Ϊ�ַ�
    MOV  AX,BUFS
    MOV  DL,10
    DIV  DL
    ADD  AH,30H
    MOV  RES+1,AH
    MOV  AH,0
    DIV  DL
    ADD  AH,30H
    MOV  RES+0,AH
    ADD  AL,30H
    MOV  RES-1,AL
    ENDM  
    
   
   
    LEA  DX,BUF                     ;��ʾϵͳ�ײ�����
    MOV  AH,9                     
    INT  21H
    
    


CALCULATESUM:                       ;��������ѧ���ɼ��ܺ�
    MOV  DI,0
    LEA  BX,BUF1 
ALLSTUDENT:  
    MOV  [BX+65],WORD PTR 0         ;��SUMΪ0
    MOV  SI,0
    MOV  CX,COUNT                   ;COUNTΪ��Ŀ��
ASTUDENT:
    CHANGESTN  [BX+SI+9],[BX+65]
    ADD  SI,8
    LOOP ASTUDENT
    MOV  SI,DI
    MOV  AX,2
    IMUL SI,AX                      ;������ܷ����������RESULT��
    MOV  AX,[BX+65]                 ;��������ʱʹ��
    MOV  RESULT[SI],AX  
    CHANGENTS  [BX+65],[BX+65]
    INC  DI
    MOV  AX,SUM
    IMUL AX,DI
    MOV  SI,AX
    LEA  BX,BUF1[SI]
    CMP  DI,26
    JNE  ALLSTUDENT 



                                    ;��������
RANKING:                            ;�����ȵݼ���������ʼʱ��DXΪ26������
    LEA  BX,BUF1                    ;�ֵܷ��ڸ�ѧ���ģ�DX-1,�����������һ����
    MOV  SI,-2                      ;ֱ������26��ѧ��
LOOPL:
    ADD  SI,2
    MOV  AX,RESULT[SI]
    MOV  DX,26
    MOV  DI,0
CP: 
    ADD  DI,2
    CMP  DI,52
    JE   LOOPK
    CMP  AX,RESULT[DI]
    JGE  TIMES
    JMP  CP         
TIMES:
    DEC  DX
    JMP  CP
LOOPK:
    SHR  SI,1
    MOV  CX,SI
    MOV  AX,SUM
    IMUL SI,AX
    MOV  [BX+SI+72],DX
    CHANGENTS  [BX+SI+72],[BX+SI+72]
    MOV  SI,CX
    SHL  SI,1
    CMP  SI,52
    JE   MAIN 
    JMP  LOOPL 
    


MAIN:                                     ;��ʾ������ѡ��
    LEA  DX,MAINSHOW          
    MOV  AH,9                      
    INT  21H
    LEA  DX,CHOICESHOW                    ;10������ѡ������
    MOV  AH,10
    INT  21H
    CMP  CHOICESHOW+2,'A'                 ;������ΪA��ִ�����һ���¿�Ŀ�ɼ�
    JZ   ADDSCORE        
    CMP  CHOICESHOW+2,'S'                 ;������ΪS��ִ����ʾ����ѧ���ɼ�
    JZ   SHOWALL
    CMP  CHOICESHOW+2,'F'                 ;������ΪF��ִ�а�ѧ�Ų�ѯѧ���ɼ� 
    JZ   FINDID
    CMP  CHOICESHOW+2,'E'                 ;������ΪE���˳�ϵͳ����������
    JZ   OUTEXIT
    JMP  INVALID                          ;�����벻Ϊ����4�֣���ʾ�������Ϸ�
INVALID:                                  ;����������
    LEA  DX,ENTERSHOW
    MOV  AH,9
    INT  21H
    LEA  DX,INVALIDSHOW
    MOV  AH,9
    INT  21H
    JMP  MAIN    




ADDSCORE:                                 ;ִ�����һ���¿�Ŀ�ɼ�
    CALL ADDS
    JMP  CALCULATESUM

SHOWALL:                                  ;ִ����ʾ����ѧ���ɼ�
    CALL SHOW                             
    JMP  MAIN

FINDID:                                   ;ִ�а�ѧ�Ų�ѯѧ���ɼ� 
    CALL FIND
    JMP  MAIN
    
OUTEXIT:                                  ;�˳�ϵͳ����������
    MOV  AH,4CH
    INT  21H
    



ADDS PROC                                 ;��ӿ�Ŀ��26��ѧ���ɼ����ӳ���
    PUSH CX
	PUSH SI
    PUSH DI
    PUSH AX
    PUSH BX
    LEA  DX,ENTERSHOW
    MOV  AH,9
    INT  21H
    LEA  DX,NEWSUBJECT
    MOV  AH,9
    INT  21H
    LEA  DX,SUBJECTNAME
    MOV  AH,10
    INT  21H
    MOV  BL,[SUBJECTNAME+1]
    MOV  BH,0
    MOV  CX,BX
    MOV  SI,2
    MOV  DI,48
ADDNAME:
    MOV  AL,SUBJECTNAME[SI]
    MOV  SUBJECT[DI],AL
    INC  SI
    INC  DI
    LOOP ADDNAME
    LEA  DX,ENTERSHOW
    MOV  AH,9
    INT  21H
    LEA  DX,ADDTIP
    MOV  AH,9
    INT  21H
    MOV  SI,0
    MOV  DI,0
ASCORE:
    LEA  BX,BUF1
    LEA  DX,STUDENT
    MOV  AH,9
    INT  21H
    MOV  CX,3
R:  MOV  DL,STUDENTID[SI]
    MOV  AH,2
    INT  21H
    INC  SI
    LOOP R
    LEA  DX,SCORES
    MOV  AH,10
    INT  21H
    MOV  AX,SUM
    IMUL DI,AX
    MOV  AL,SCORES+2
    MOV  [BX+DI+49],AL
    MOV  AL,SCORES+3
    MOV  [BX+DI+50],AL
    LEA  DX,ENTERSHOW
    MOV  AH,9
    INT  21H
    XOR  EAX,EAX
    XOR  EDX,EDX
    MOV  AX,DI
    MOV  BX,SUM
    IDIV BX
    MOV  DI,AX
    INC  DI
    CMP  DI,26
    JNE  ASCORE
    MOV  AX,COUNT
    INC  AX
    MOV  COUNT,AX
    LEA  DX,ENTERSHOW
    MOV  AH,9
    INT  21H    
    POP  BX
    POP  AX
    POP  DI
    POP  SI
    POP  CX
    RET
ADDS ENDP
    






SHOW PROC                           ;��ʾ����ѧ���ɼ����ӳ���
    PUSH SI
    PUSH CX
    LEA  DX,ENTERSHOW
    MOV  AH,9
    INT  21H
    LEA  DX,SUBJECT
    MOV  AH,9
    INT  21H
    MOV  SI,0
    MOV  CX,26
L:
    LEA  DX,BUF1[SI]
    MOV  AH,9
    INT  21H
    ADD  SI,SUM
    LOOP L
    POP  CX
    POP  SI
    RET
SHOW ENDP





FIND PROC                         ;��ѧ�Ų���ѧ���ӳ���
    PUSH AX
    PUSH BX
    PUSH SI
    LEA  DX,ENTERSHOW
    MOV  AH,9
    INT  21H
LOOPB:   
    LEA  DX,INPUTID
    MOV  AH,9
    INT  21H
    LEA  DX,ID
    MOV  AH,10
    INT  21H
    MOV  AH,ID+2
    CMP  AH,'B'
    JE   EXIT
    SUB  AH,30H
    MOV  AL,ID+3
    SUB  AL,30H
    XOR  BX,BX
    MOV  BL,AH
    IMUL BX,10
    MOV  AH,0
    ADD  BX,AX
    CMP  BX,26
    JG   NOTEXISTS
    CMP  BX,1
    JL   NOTEXISTS
    DEC  BX
    MOV  AX,SUM
    IMUL BX,AX
    MOV  SI,BX
    LEA  DX,ENTERSHOW
    MOV  AH,9
    INT  21H
    LEA  DX,SUBJECT
    MOV  AH,9
    INT  21H 
    LEA  DX,BUF1[SI]
    MOV  AH,9
    INT  21H 
    JMP  LOOPB
NOTEXISTS:
    LEA  DX,ENTERSHOW
    MOV  AH,9
    INT  21H
    LEA  DX,NOTEXIST
    MOV  AH,9
    INT  21H 
    JMP  LOOPB    
EXIT:
    LEA  DX,ENTERSHOW
    MOV  AH,9
    INT  21H 
    POP  SI
    POP  BX
    POP  AX
    RET
FIND ENDP


    
CODES ENDS
    END START




