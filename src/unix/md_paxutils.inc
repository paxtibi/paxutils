const
  MILLIUNITS = 1000;         // milli units per base unit
  MICROUNITS = 1000000;      // micro units per base unit
  NANOUNITS = 1000000000;   // nano units per base unit
  NANOUNITS_PER_MILLIUNIT = NANOUNITS div MILLIUNITS;

  NANOSECS_PER_SEC = uint64(1000000000);
  NANOSECS_PER_MILLISEC = 1000000;


function TOS.currentTimeMillis: uint64;
var
  ts: TTimeSpec;
  status: int32;
begin
  status := clock_gettime(CLOCK_REALTIME, @ts);
  Result := uint64(ts.tv_sec) * MILLIUNITS + uint64(ts.tv_nsec) div NANOUNITS_PER_MILLIUNIT;
end;

procedure TOS.init;
begin
end;


