using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppService.Class
{
    
}

public class Student
{
    public int StudentID { get; set; }
    public string AdminNo { get; set; }
    public string PEMGrp { get; set; }
    public string Course { get; set; }
    public int Age { get; set; }
    public string Gender { get; set; }
    public float GPAS1 { get; set; }
    public float GPAS2 { get; set; }
    public string CreateBy { get; set; }
    public DateTime CreateDate { get; set; }
    public string AmendBy { get; set; }
    public DateTime AmendDate { get; set; }

    public Student()
    {

    }

    public Student(int studentid, string admno, string pemgrp, string crs, int age, string gedr, float gpas1, float gpas2, string cBy, DateTime cDate, string aBy, DateTime aDate)
    {
        StudentID = studentid;
        AdminNo = admno;
        PEMGrp = pemgrp;
        Course = crs;
        Age = age;
        Gender = gedr;
        GPAS1 = gpas1;
        GPAS2 = gpas2;
        CreateBy = cBy;
        CreateDate = cDate;
        AmendBy = aBy;
        AmendDate = aDate;
    }
}
