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
         DB "AND B FOR BACK TO MIAN",0DH,0AH,'$'
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
     DB 200 DUP(0);此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT  USE16
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV  AX,DATAS
    MOV  DS,Ax
    
CHANGESTN MACRO BUFS,RES      
    MOV  AH,BUFS                    ;宏定义将BUFS所对应的字节变量里面的字符
    SUB  AH,30H                     ;转换为十进制数，并依次将所得数加在RES
    MOV  AL,BUFS+1                  ;字节变量所对应的字单元中
    SUB  AL,30H
    XOR  DX,DX
    MOV  DL,AH
    IMUL DX,10
    MOV  AH,0
    ADD  DX,AX
    ADD  RES,DX
    ENDM    
    
CHANGENTS MACRO BUFS,RES            ;宏定义将以BUFS为偏移地址的两个字节单元
    XOR  AX,AX                      ;表示的十进制数转换为字符
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
    
   
   
    LEA  DX,BUF                     ;显示系统首部界面
    MOV  AH,9                     
    INT  21H
    
    


CALCULATESUM:                       ;计算所有学生成绩总和
    MOV  DI,0
    LEA  BX,BUF1 
ALLSTUDENT:  
    MOV  [BX+65],WORD PTR 0         ;置SUM为0
    MOV  SI,0
    MOV  CX,COUNT                   ;COUNT为科目数
ASTUDENT:
    CHANGESTN  [BX+SI+9],[BX+65]
    ADD  SI,8
    LOOP ASTUDENT
    MOV  SI,DI
    MOV  AX,2
    IMUL SI,AX                      ;将算得总分依次另存在RESULT中
    MOV  AX,[BX+65]                 ;便于排名时使用
    MOV  RESULT[SI],AX  
    CHANGENTS  [BX+65],[BX+65]
    INC  DI
    MOV  AX,SUM
    IMUL AX,DI
    MOV  SI,AX
    LEA  BX,BUF1[SI]
    CMP  DI,26
    JNE  ALLSTUDENT 



                                    ;计算排名
RANKING:                            ;逐个相比递减排名，开始时置DX为26，若有
    LEA  BX,BUF1                    ;总分低于该学生的，DX-1,否则继续比下一个，
    MOV  SI,-2                      ;直至比完26个学生
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
    


MAIN:                                     ;显示命令行选项
    LEA  DX,MAINSHOW          
    MOV  AH,9                      
    INT  21H
    LEA  DX,CHOICESHOW                    ;10号输入选择命令
    MOV  AH,10
    INT  21H
    CMP  CHOICESHOW+2,'A'                 ;若输入为A，执行添加一门新科目成绩
    JZ   ADDSCORE        
    CMP  CHOICESHOW+2,'S'                 ;若输入为S，执行显示所有学生成绩
    JZ   SHOWALL
    CMP  CHOICESHOW+2,'F'                 ;若输入为F，执行按学号查询学生成绩 
    JZ   FINDID
    CMP  CHOICESHOW+2,'E'                 ;若输入为E，退出系统，结束运行
    JZ   OUTEXIT
    JMP  INVALID                          ;若输入不为以上4种，显示操作不合法
INVALID:                                  ;请重新输入
    LEA  DX,ENTERSHOW
    MOV  AH,9
    INT  21H
    LEA  DX,INVALIDSHOW
    MOV  AH,9
    INT  21H
    JMP  MAIN    




ADDSCORE:                                 ;执行添加一门新科目成绩
    CALL ADDS
    JMP  CALCULATESUM

SHOWALL:                                  ;执行显示所有学生成绩
    CALL SHOW                             
    JMP  MAIN

FINDID:                                   ;执行按学号查询学生成绩 
    CALL FIND
    JMP  MAIN
    
OUTEXIT:                                  ;退出系统，结束运行
    MOV  AH,4CH
    INT  21H
    



ADDS PROC                                 ;添加科目及26个学生成绩的子程序
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
    






SHOW PROC                           ;显示所有学生成绩的子程序
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





FIND PROC                         ;按学号查找学生子程序
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




