{inputs, ...}: _final: prev: {
  zjstatus = inputs.zjstatus.packages.${prev.system}.default;
}
