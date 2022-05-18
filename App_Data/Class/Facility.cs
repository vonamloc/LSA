using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

public class Facility
{
    public string FacilityID { get; set; }
    public string FacilityCode { get; set; }
    public int ProjPhaseID  { get; set; }
    public string CreateBy { get; set; }
    public DateTime CreateDate { get; set; }
    public string AmendBy { get; set; }
    public DateTime AmendDate { get; set; }

    public Facility()
    {

    }

    public Facility(string faciid, string facicode, int projphaseid, string cBy, DateTime cDate, string aBy, DateTime aDate)
    {
        FacilityID = faciid;
        FacilityCode = facicode;
        ProjPhaseID = projphaseid;
        CreateBy = cBy;
        CreateDate = cDate;
        AmendBy = aBy;
        AmendDate = aDate;
    }
}
