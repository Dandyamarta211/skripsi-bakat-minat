<div class="box box-primary">
    <div class="box-header with-border">
        <h3 class="box-title">Form <?=$judul?></h3>
        <div class="box-tools pull-right">
            <a href="<?=base_url()?>jurusanketerampilan" class="btn btn-warning btn-flat btn-sm">
                <i class="fa fa-arrow-left"></i> Batal
            </a>
        </div>
    </div>
    <div class="box-body">
        <div class="row">
            <div class="col-sm-4 col-sm-offset-4">
                    <?=form_open('jurusanketerampilan/save', array('id'=>'jurusanketerampilan'), array('method'=>'edit', 'keterampilan_id'=>$id_keterampilan))?>
                <div class="form-group">
                    <label>Keterampilan</label>
                    <input type="text" readonly="readonly" value="<?=$keterampilan->nama_keterampilan?>" class="form-control">
                    <small class="help-block text-right"></small>
                </div>
                <div class="form-group">
                    <label>Jurusan</label>
                    <select id="jurusan" multiple="multiple" name="jurusan_id[]" class="form-control select2" style="width: 100%!important">
                        <?php 
                        $sj = [];
                        foreach ($jurusan as $key => $val) {
                            $sj[] = $val->id_jurusan;
                        }
                        foreach ($all_jurusan as $m) : ?>
                            <option <?=in_array($m->id_jurusan, $sj) ? "selected" : "" ?> value="<?=$m->id_jurusan?>"><?=$m->nama_jurusan?></option>
                        <?php endforeach; ?>
                    </select>
                    <small class="help-block text-right"></small>
                </div>
                <div class="form-group pull-right">
                    <button type="reset" class="btn btn-flat btn-default">
                        <i class="fa fa-rotate-left"></i> Reset
                    </button>
                    <button id="submit" type="submit" class="btn btn-flat bg-purple">
                        <i class="fa fa-save"></i> Simpan
                    </button>
                </div>
                <?=form_close()?>
            </div>
        </div>
    </div>
</div>

<script src="<?=base_url()?>assets/dist/js/app/relasi/jurusanketerampilan/edit.js"></script>