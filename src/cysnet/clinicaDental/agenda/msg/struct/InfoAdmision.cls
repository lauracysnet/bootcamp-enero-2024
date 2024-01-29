Class cysnet.clinicaDental.agenda.msg.struct.InfoAdmision Extends (%SerialObject, %XML.Adaptor)
{

Property paciente As cysnet.clinicaDental.agenda.msg.BuscarPacientePorIDResponse;

Property admision As cysnet.clinicaDental.agenda.msg.BuscarAdmisionPorCitaResponse;

Storage Default
{
<Data name="AdmisionState">
<Value name="1">
<Value>IdAdmision</Value>
</Value>
<Value name="2">
<Value>IdCita</Value>
</Value>
<Value name="3">
<Value>FechaAdmision</Value>
</Value>
<Value name="4">
<Value>IndEnviada</Value>
</Value>
<Value name="5">
<Value>idAdmision</Value>
</Value>
<Value name="6">
<Value>fechaAdmision</Value>
</Value>
<Value name="7">
<Value>idPaciente</Value>
</Value>
<Value name="8">
<Value>nombre</Value>
</Value>
<Value name="9">
<Value>apellidos</Value>
</Value>
<Value name="10">
<Value>paciente</Value>
</Value>
<Value name="11">
<Value>admision</Value>
</Value>
</Data>
<State>AdmisionState</State>
<StreamLocation>^cysnet.clinicaDent8AF.AdmisionS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
