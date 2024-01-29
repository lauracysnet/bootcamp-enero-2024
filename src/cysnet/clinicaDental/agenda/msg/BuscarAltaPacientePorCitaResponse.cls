Class cysnet.clinicaDental.agenda.msg.BuscarAltaPacientePorCitaResponse Extends Ens.Response
{

Property idAlta As %Integer;

Property idCita As %Integer;

Property fechaAlta As %TimeStamp;

Property exito As %Boolean;

Property error As %String(MAXLEN = "");

Storage Default
{
<Data name="BuscarAltaPacientePorCitaResponseDefaultData">
<Subscript>"BuscarAltaPacientePorCitaResponse"</Subscript>
<Value name="1">
<Value>idAlta</Value>
</Value>
<Value name="2">
<Value>idCita</Value>
</Value>
<Value name="3">
<Value>fechaAlta</Value>
</Value>
<Value name="4">
<Value>exito</Value>
</Value>
<Value name="5">
<Value>error</Value>
</Value>
</Data>
<DefaultData>BuscarAltaPacientePorCitaResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
