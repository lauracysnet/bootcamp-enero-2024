Class cysnet.clinicaDental.agenda.bs.InSQLAltas Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.SQL.InboundAdapter";

Method OnProcessInput(pInput As EnsLib.SQL.Snapshot, Output pOutput As %RegisteredObject) As %Status
{
    #dim req as cysnet.clinicaDental.agenda.msg.AltaPacienteRequest
    #dim rsp As cysnet.clinicaDental.agenda.msg.AltaPacienteResponse

    set req = ##class(cysnet.clinicaDental.agenda.msg.AltaPacienteRequest).%New()
    set req.idCita = pInput.Get("IdCita")
    quit ..SendRequestSync("ProcesoCitas",req,.rsp)
}

}
