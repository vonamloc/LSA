using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class Parameter
{
    public string ParaCode1 { get; set; }
    public string ParaCode2 { get; set; }
    public string ParaCode3 { get; set; }
    public string Desc1 { get; set; }
    public string Desc2 { get; set; }
    public string CreateBy { get; set; }
    public DateTime CreateDate { get; set; }
    public string AmendBy { get; set; }
    public DateTime AmendDate { get; set; }

    public Parameter()
    {

    }

    public Parameter(string p1, string p2, string p3, string d1, string d2, string cBy, DateTime cDate, string aBy, DateTime aDate)
    {
        ParaCode1 = p1;
        ParaCode2 = p2;
        ParaCode3 = p3;
        Desc1 = d1;
        Desc2 = d2;
        CreateBy = cBy;
        CreateDate = cDate;
        AmendBy = aBy;
        AmendDate = aDate;
    }
}