using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class Questionnaire
{
    public int QnsID { get; set; }
    public int QnsNo { get; set; }
    public string Type { get; set; }
    public string Category { get; set; }
    public string Desc { get; set; }
    public bool HasQnsGroup { get; set; }
    public int QnsGroupID { get; set; }
    public bool Optional { get; set; }
    public string CreateBy { get; set; }
    public DateTime CreateDate { get; set; }
    public string AmendBy { get; set; }
    public DateTime AmendDate { get; set; }

    public Questionnaire()
    {

    }

    public Questionnaire(int qnsid, int qnsno, string type, string category, string desc, bool hasqnsgrp, int qnsgrpid, bool optional, string cBy, DateTime cDate, string aBy, DateTime aDate)
    {
        QnsID = qnsid;
        QnsNo = qnsno;
        Type = type;
        Category = category;
        Desc = desc;
        HasQnsGroup = hasqnsgrp;
        QnsGroupID = qnsgrpid;
        Optional = optional;
        CreateBy = cBy;
        CreateDate = cDate;
        AmendBy = aBy;
        AmendDate = aDate;
    }
}
