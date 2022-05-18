using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Lesson
{
    public int LessonID { get; set; }
    public string LessonType { get; set; }
    public string ModuleCode { get; set; }
    public string ModuleGrp1 { get; set; }
    public string ModuleGrp2 { get; set; }
    public string ModuleGrp3 { get; set; }
    public string ModuleGrp4 { get; set; }
    public string ModuleGrp5 { get; set; }
    public string ModuleGrp6 { get; set; }
    public string ModuleGrp7 { get; set; }
    public string ModuleGrp8 { get; set; }
    public string TIC1 { get; set; }
    public string TIC2 { get; set; }
    public string TIC3 { get; set; }
    public string TIC4 { get; set; }
    public string FacilityID { get; set; }
    public string DayOfWeek { get; set; }
    public bool ELearnEvenWeek { get; set; }
    public DateTime TimeStart { get; set; }
    public DateTime TimeEnd { get; set; }
    public int WeekStart { get; set; }
    public int WeekEnd { get; set; }
    public string Semester { get; set; }
    public string CreateBy { get; set; }
    public DateTime CreateDate { get; set; }
    public string AmendBy { get; set; }
    public DateTime AmendDate { get; set; }

    public Lesson()
    {

    }

    public Lesson(int lessonid, string lessontype, string modcode, string modgrp1, string modgrp2, string modgrp3, string modgrp4, string modgrp5, string modgrp6, string modgrp7, string modgrp8, string tic1, string tic2, string tic3, string tic4, string faciid, string dayofweek, bool elearnevenWk, DateTime tStart, DateTime tEnd, int wkStart, int wkEnd, string semester, string cBy, DateTime cDate, string aBy, DateTime aDate)
    {
        LessonID = lessonid;
        LessonType = lessontype;
        ModuleCode = modcode;
        ModuleGrp1 = modgrp1;
        ModuleGrp2 = modgrp2;
        ModuleGrp3 = modgrp3;
        ModuleGrp4 = modgrp4;
        ModuleGrp5 = modgrp5;
        ModuleGrp6 = modgrp6;
        ModuleGrp7 = modgrp7;
        ModuleGrp8 = modgrp8;
        TIC1 = tic1;
        TIC2 = tic2;
        TIC3 = tic3;
        TIC4 = tic4;
        FacilityID = faciid;
        DayOfWeek = dayofweek;
        ELearnEvenWeek = elearnevenWk;
        TimeStart = tStart;
        TimeEnd = tEnd;
        WeekStart = wkStart;
        WeekEnd = wkEnd;
        Semester = semester;
        CreateBy = cBy;
        CreateDate = cDate;
        AmendBy = aBy;
        AmendDate = aDate;
    }
}