using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class Program
{
    public int ProgID { get; set; }
    public string ProgName { get; set; }
    public string ProgDesc { get; set; }
    public string CreateBy { get; set; }
    public DateTime CreateDate { get; set; }
    public string AmendBy { get; set; }
    public DateTime AmendDate { get; set; }

    public Program() { }

    public Program(int progid, string progname, string progdesc, string cBy, DateTime cDate, string aBy, DateTime aDate)
    {
        ProgID = progid;
        ProgName = progname;
        ProgDesc = progdesc;
        CreateBy = cBy;
        CreateDate = cDate;
        AmendBy = aBy;
        AmendDate = aDate;
    }
}