<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Master_model extends CI_Model {

    public function create($table, $data, $batch = false)
    {
        if($batch === false){
            $insert = $this->db->insert($table, $data);
        }else{
            $insert = $this->db->insert_batch($table, $data);
        }
        return $insert;
    }

    public function update($table, $data, $pk, $id = null, $batch = false)
    {
        if($batch === false){
            $insert = $this->db->update($table, $data, array($pk => $id));
        }else{
            $insert = $this->db->update_batch($table, $data, $pk);
        }
        return $insert;
    }

    public function delete($table, $data, $pk)
    {
        $this->db->where_in($pk, $data);
        return $this->db->delete($table);
    }

    /**
     * Data Kelas
     */

    public function getDataKelas()
    {
        $this->datatables->select('id_kelas, nama_kelas, id_jurusan, nama_jurusan');
        $this->datatables->from('kelas');
        $this->datatables->join('jurusan', 'jurusan_id=id_jurusan');
        $this->datatables->add_column('bulk_select', '<div class="text-center"><input type="checkbox" class="check" name="checked[]" value="$1"/></div>', 'id_kelas, nama_kelas, id_jurusan, nama_jurusan');        
        return $this->datatables->generate();
    }

    public function getKelasById($id)
    {
        $this->db->where_in('id_kelas', $id);
        $this->db->order_by('nama_kelas');
        $query = $this->db->get('kelas')->result();
        return $query;
    }

    /**
     * Data Jurusan
     */

    public function getDataJurusan()
    {
        $this->datatables->select('id_jurusan, nama_jurusan');
        $this->datatables->from('jurusan');
        $this->datatables->add_column('bulk_select', '<div class="text-center"><input type="checkbox" class="check" name="checked[]" value="$1"/></div>', 'id_jurusan, nama_jurusan');
        return $this->datatables->generate();
    }

    public function getJurusanById($id)
    {
        $this->db->where_in('id_jurusan', $id);
        $this->db->order_by('nama_jurusan');
        $query = $this->db->get('jurusan')->result();
        return $query;
    }

    /**
     * Data Siswa
     */

    public function getDataSiswa()
    {
        $this->datatables->select('a.id_siswa, a.nama, a.nim, a.email, b.nama_kelas, c.nama_jurusan');
        $this->datatables->select('(SELECT COUNT(id) FROM users WHERE username = a.nim) AS ada');
        $this->datatables->from('siswa a');
        $this->datatables->join('kelas b', 'a.kelas_id=b.id_kelas');
        $this->datatables->join('jurusan c', 'b.jurusan_id=c.id_jurusan');
        return $this->datatables->generate();
    }

    public function getSiswaById($id)
    {
        $this->db->select('*');
        $this->db->from('siswa');
        $this->db->join('kelas', 'kelas_id=id_kelas');
        $this->db->join('jurusan', 'jurusan_id=id_jurusan');
        $this->db->where(['id_siswa' => $id]);
        return $this->db->get()->row();
    }

    public function getJurusan()
    {
        $this->db->select('id_jurusan, nama_jurusan');
        $this->db->from('kelas');
        $this->db->join('jurusan', 'jurusan_id=id_jurusan');
        $this->db->order_by('nama_jurusan', 'ASC');
        $this->db->group_by('id_jurusan');
        $query = $this->db->get();
        return $query->result();
    }

    public function getAllJurusan($id = null)
    {
        if($id === null){
            $this->db->order_by('nama_jurusan', 'ASC');
            return $this->db->get('jurusan')->result();    
        }else{
            $this->db->select('jurusan_id');
            $this->db->from('jurusan_keterampilan');
            $this->db->where('keterampilan_id', $id);
            $jurusan = $this->db->get()->result();
            $id_jurusan = [];
            foreach ($jurusan as $j) {
                $id_jurusan[] = $j->jurusan_id;
            }
            if($id_jurusan === []){
                $id_jurusan = null;
            }
            
            $this->db->select('*');
            $this->db->from('jurusan');
            $this->db->where_not_in('id_jurusan', $id_jurusan);
            $keterampilan = $this->db->get()->result();
            return $keterampilan;
        }
    }

    public function getKelasByJurusan($id)
    {
        $query = $this->db->get_where('kelas', array('jurusan_id'=>$id));
        return $query->result();
    }

    /**
     * Data guru
     */

    public function getDataGuru()
    {
        $this->datatables->select('a.id_guru,a.nip, a.nama_guru, a.email, a.keterampilan_id, b.nama_keterampilan, (SELECT COUNT(id) FROM users WHERE username = a.nip OR email = a.email) AS ada');
        $this->datatables->from('guru a');
        $this->datatables->join('keterampilan b', 'a.keterampilan_id=b.id_keterampilan');
        return $this->datatables->generate();
    }

    public function getGuruById($id)
    {
        $query = $this->db->get_where('guru', array('id_guru'=>$id));
        return $query->row();
    }

    /**
     * Data Keterampilan
     */

    public function getDataKeterampilan()
    {
        $this->datatables->select('id_keterampilan, nama_keterampilan');
        $this->datatables->from('keterampilan');
        return $this->datatables->generate();
    }

    public function getAllKeterampilan()
    {
        return $this->db->get('keterampilan')->result();
    }

    public function getKeterampilanById($id, $single = false)
    {
        if($single === false){
            $this->db->where_in('id_keterampilan', $id);
            $this->db->order_by('nama_keterampilan');
            $query = $this->db->get('keterampilan')->result();
        }else{
            $query = $this->db->get_where('keterampilan', array('id_keterampilan'=>$id))->row();
        }
        return $query;
    }

    /**
     * Data Kelas guru
     */

    public function getKelasGuru()
    {
        $this->datatables->select('kelas_guru.id, guru.id_guru, guru.nip, guru.nama_guru, GROUP_CONCAT(kelas.nama_kelas) as kelas');
        $this->datatables->from('kelas_guru');  
        $this->datatables->join('kelas', 'kelas_id=id_kelas');
        $this->datatables->join('guru', 'guru_id=id_guru');
        $this->datatables->group_by('guru.nama_guru');
        return $this->datatables->generate();
    }

    public function getAllGuru($id = null)
    {
        $this->db->select('guru_id');
        $this->db->from('kelas_guru');
        if($id !== null){
            $this->db->where_not_in('guru_id', [$id]);
        }
        $guru = $this->db->get()->result();
        $id_guru = [];
        foreach ($guru as $d) {
            $id_guru[] = $d->guru_id;
        }
        if($id_guru === []){
            $id_guru = null;
        }

        $this->db->select('id_guru, nip, nama_guru');
        $this->db->from('guru');
        $this->db->where_not_in('id_guru', $id_guru);
        return $this->db->get()->result();
    }

    
    public function getAllKelas()
    {
        $this->db->select('id_kelas, nama_kelas, nama_jurusan');
        $this->db->from('kelas');
        $this->db->join('jurusan', 'jurusan_id=id_jurusan');
        $this->db->order_by('nama_kelas');
        return $this->db->get()->result();
    }
    
    public function getKelasByGuru($id)
    {
        $this->db->select('kelas.id_kelas');
        $this->db->from('kelas_guru');
        $this->db->join('kelas', 'kelas_guru.kelas_id=kelas.id_kelas');
        $this->db->where('guru_id', $id);
        $query = $this->db->get()->result();
        return $query;
    }
    /**
     * Data Jurusan Keterampilan
     */

    public function getJurusanKeterampilan()
    {
        $this->datatables->select('jurusan_keterampilan.id, keterampilan.id_keterampilan, keterampilan.nama_keterampilan, jurusan.id_jurusan, GROUP_CONCAT(jurusan.nama_jurusan) as nama_jurusan');
        $this->datatables->from('jurusan_keterampilan');
        $this->datatables->join('keterampilan', 'keterampilan_id=id_keterampilan');
        $this->datatables->join('jurusan', 'jurusan_id=id_jurusan');
        $this->datatables->group_by('keterampilan.nama_keterampilan');
        return $this->datatables->generate();
    }

    public function getKeterampilan($id = null)
    {
        $this->db->select('keterampilan_id');
        $this->db->from('jurusan_keterampilan');
        if($id !== null){
            $this->db->where_not_in('keterampilan_id', [$id]);
        }
        $keterampilan = $this->db->get()->result();
        $id_keterampilan = [];
        foreach ($keterampilan as $d) {
            $id_keterampilan[] = $d->keterampilan_id;
        }
        if($id_keterampilan === []){
            $id_keterampilan = null;
        }

        $this->db->select('id_keterampilan, nama_keterampilan');
        $this->db->from('keterampilan');
        $this->db->where_not_in('id_keterampilan', $id_keterampilan);
        return $this->db->get()->result();
    }

    public function getJurusanByIdKeterampilan($id)
    {
        $this->db->select('jurusan.id_jurusan');
        $this->db->from('jurusan_keterampilan');
        $this->db->join('jurusan', 'jurusan_keterampilan.jurusan_id=jurusan.id_jurusan');
        $this->db->where('keterampilan_id', $id);
        $query = $this->db->get()->result();
        return $query;
    }
}