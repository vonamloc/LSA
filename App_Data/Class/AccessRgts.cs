using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class AccessRgts
{
    public int AccessID { get; set; }
    public int ProgID { get; set; }
    public string LoginID { get; set; }
    public string CreateBy { get; set; }
    public DateTime CreateDate { get; set; }
    public string AmendBy { get; set; }
    public DateTime AmendDate { get; set; }

    public AccessRgts()
    {

    }

    public AccessRgts(int accessid, int progid, string loginid, string cBy, DateTime cDate, string aBy, DateTime aDate)
    {
        AccessID = accessid;
        ProgID = progid;
        LoginID = loginid;
        CreateBy = cBy;
        CreateDate = cDate;
        AmendBy = aBy;
        AmendDate = aDate;
    }
}
