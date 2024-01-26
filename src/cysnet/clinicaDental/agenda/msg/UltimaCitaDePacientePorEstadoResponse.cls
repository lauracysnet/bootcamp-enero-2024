Class cysnet.clinicaDental.agenda.msg.UltimaCitaDePacientePorEstadoResponse Extends (Ens.Request, cysnet.clinicaDental.agenda.msg.struct.infoCita)
{

Property mensaje As %String(MAXLEN = "");

Property exito As %Boolean;

Storage Default
{
<Data name="UltimaCitaDePacientePorEstadoResponseDefaultData">
<Subscript>"UltimaCitaDePacientePorEstadoResponse"</Subscript>
<Value name="1">
<Value>idCita</Value>
</Value>
<Value name="2">
<Value>idPaciente</Value>
</Value>
<Value name="3">
<Value>descCita</Value>
</Value>
<Value name="4">
<Value>fechaCita</Value>
</Value>
<Value name="5">
<Value>codEstado</Value>
</Value>
<Value name="6">
<Value>mensaje</Value>
</Value>
<Value name="7">
<Value>exito</Value>
</Value>
</Data>
<DefaultData>UltimaCitaDePacientePorEstadoResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
