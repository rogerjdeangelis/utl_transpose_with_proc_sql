    Transpose with proc sql

    github
    https://tinyurl.com/y7jf363u
    https://github.com/rogerjdeangelis/utl_transpose_with_proc_sql

    https://stackoverflow.com/questions/51060039/transpose-with-proc-sql


    INPUT
    =====

    SASHELP.BASEBALL total obs=322

     NAME                 TEAM             NATBAT    NHITS    NHOME    NRUNS    NRBI    NBB .. LOGSALARY

     Allanson, Andy       Cleveland          293       66        1       30       29     14 ..   .
     Ashby, Alan          Houston            315       81        7       24       38     39 ..  6.16331
     Davis, Alan          Seattle            479      130       18       66       72     76 ..  6.17379
     Dawson, Andre        Montreal           496      141       20       65       78     37 ..  6.21461
     Galarraga, Andres    Montreal           321       87       10       39       42     30 ..  4.51634
     Griffin, Alfredo     Oakland            594      169        4       74       51     35 ..  6.62007
     Newman, Al           Montreal           185       37        1       23        8     21 ..  4.24850
     Salazar, Argenis     Kansas City        298       73        0       24       24      7 ..  4.60517

    ...

     WORK.WANT total obs=5,796

            NAME         VAR              VAL

       Aldrete, Mike     CRATBAT       216.00
       Aldrete, Mike     CRBB           33.00
       Aldrete, Mike     CRHITS         54.00
       Aldrete, Mike     CRHOME          2.00
       Aldrete, Mike     CRRBI          25.00
       Aldrete, Mike     CRRUNS         27.00
       Aldrete, Mike     LOGSALARY       4.32
       Aldrete, Mike     NASSTS         36.00
       Aldrete, Mike     NATBAT        216.00
       Aldrete, Mike     NBB            33.00
       Aldrete, Mike     NERROR          1.00
       Aldrete, Mike     NHITS          54.00
       Aldrete, Mike     NHOME           2.00
       Aldrete, Mike     NOUTS         317.00
       Aldrete, Mike     NRBI           25.00
       Aldrete, Mike     NRUNS          27.00
       Aldrete, Mike     SALARY         75.00
       Aldrete, Mike     YRMAJOR         1.00
       Allanson, Andy    CRATBAT       293.00
       Allanson, Andy    CRBB           14.00
       Allanson, Andy    CRHITS         66.00
       Allanson, Andy    CRHOME          1.00


    PROCESS
    =======

    proc sql;
      * get meta data - this could take 15 minutes in EG server;
      select name into :names separated by " "
      from sashelp.vcolumn
      where libname='SASHELP' and memname="BASEBALL" and type="num"
      ;
      * very fast;
      %array(nams,values=&names)
      create
        table want as
      %do_over(nams,phrase=
        %str(select name, "?" as var, ? as val from sashelp.baseball)
        ,between=union corr)
    ;quit;

    OUTPUT

     WORK.WANT total obs=5,796

            NAME         VAR              VAL

       Aldrete, Mike     CRATBAT       216.00
       Aldrete, Mike     CRBB           33.00
       Aldrete, Mike     CRHITS         54.00
       Aldrete, Mike     CRHOME          2.00
       Aldrete, Mike     CRRBI          25.00
       Aldrete, Mike     CRRUNS         27.00
       Aldrete, Mike     LOGSALARY       4.32
       Aldrete, Mike     NASSTS         36.00
       Aldrete, Mike     NATBAT        216.00
       Aldrete, Mike     NBB            33.00
       Aldrete, Mike     NERROR          1.00
       Aldrete, Mike     NHITS          54.00
       Aldrete, Mike     NHOME           2.00
       Aldrete, Mike     NOUTS         317.00
       Aldrete, Mike     NRBI           25.00
       Aldrete, Mike     NRUNS          27.00
       Aldrete, Mike     SALARY         75.00
       Aldrete, Mike     YRMAJOR         1.00
       Allanson, Andy    CRATBAT       293.00
       Allanson, Andy    CRBB           14.00
       Allanson, Andy    CRHITS         66.00
       Allanson, Andy    CRHOME          1.00

     *               _               _       _
     _ __ ___   __ _| | _____     __| | __ _| |_ __ _
    | '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
    | | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
    |_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

    ;

      jus use sashelp.baseball


    *          _       _   _
     ___  ___ | |_   _| |_(_) ___  _ __
    / __|/ _ \| | | | | __| |/ _ \| '_ \
    \__ \ (_) | | |_| | |_| | (_) | | | |
    |___/\___/|_|\__,_|\__|_|\___/|_| |_|

    ;

    see process

